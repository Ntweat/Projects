#include <stdio.h>
#include <iostream>
#include <dirent.h>

#include "opencv2/core/core.hpp"
#include "opencv2/features2d/features2d.hpp"
#include "opencv2/highgui/highgui.hpp"
#include "opencv2/calib3d/calib3d.hpp"
#include "opencv2/nonfree/nonfree.hpp"
#include "opencv2/imgproc/imgproc.hpp"

using namespace cv;
using namespace std;

//Global Variables//
vector<String> img_names;

Mat final_img;
vector<Mat> image;
std::vector<Mat> image_gray;
double max_x = 999999, max_y = 999999 ;
double  min_x = 999999, min_y = 999999;

////////////////////////////////
void open(string foldername)
{
  int order=1;
  DIR *directory = opendir (foldername.c_str());
   
    struct dirent *_dirent = NULL;
    if(directory == NULL)
    {
        printf("Cannot open Input Folder\n");
    }
    while((_dirent = readdir(directory)) != NULL)
    {
      if(string(_dirent->d_name) != "." && string(_dirent->d_name) != ".." ){
    string fileName = foldername + "/" +string(_dirent->d_name);
    //cout << "\n     " << fileName.c_str();
    img_names.push_back(fileName.c_str());
    order++;
    }
  }
    closedir(directory);
   
}



void resizeImages(int num)
{

  for (int i = 0; i < num; ++i)
    { 

Mat tt = imread(img_names[i]);
float wPercent = (500.0000/tt.cols);
int height = int(tt.rows* wPercent);
Size size (500, height);
resize(tt,tt, size);
image.push_back(tt);
}
}


int stitch (int num)
{

SurfFeatureDetector detector(400);
vector< KeyPoint > key;
Mat deskey;
detector.detect(final_img, key);
SurfDescriptorExtractor extractor;
extractor.compute(final_img, key, deskey);
FlannBasedMatcher matcher;
imwrite("cheeee.jpg", final_img);
/// Variable to store the best match //

int best_num = 0;                // image index
std::vector<DMatch> Best_match;  // store all matches
std::vector<KeyPoint> Best_key;  // store key features
Mat Best_des;                    // store descriptors
std::vector<DMatch> Best_match_sub; // Store best matches
float Best_rat = 0.0;                       // Best ratio
Mat Best_H;                         // H matrix of best match
float Best_avg; 
Mat BestIm;
//////////////////////////////////////////////////

for (int i = 1; i < num; i++ )
{

Mat next_c = image[i];
 //cvtColor(next_c, next_c, CV_BGR2GRAY);
 //GaussianBlur(next_c, next_c, Size(5,5), 0);

vector< KeyPoint > keyobj;
Mat desobj;
detector.detect(next_c, keyobj);
extractor.compute(next_c, keyobj, desobj);
cout << "\n Matching   ";
vector<DMatch> matches;
matcher.match(desobj, deskey, matches);

 double max_dist = 0; double min_dist = 100;

  for( int i = 0; i < desobj.rows; i++ )
  { double dist = matches[i].distance;
    if( dist < min_dist ) min_dist = dist;
    if( dist > max_dist ) max_dist = dist;
  }


  std::vector< DMatch > good_matches;

  if (min_dist == 0)
  min_dist = max_dist/100;

   for( int i = 0; i < matches.size(); i++ )
    {
      if( matches[i].distance < 2*min_dist )
       {
           good_matches.push_back( matches[i]);
       }
    }

std::vector<Point2f> objj;
std::vector<Point2f> scenej;

  for( int j = 0; j < good_matches.size(); j++ )
  {
    objj.push_back( keyobj[ good_matches[j].queryIdx ].pt );
    scenej.push_back( key[ good_matches[j].trainIdx ].pt );
  }
  Mat mask;
  
int yi;
if(good_matches.size() >= 4)
{
Mat H = findHomography( objj, scenej, CV_RANSAC, 5.0, mask );


int masknum =0;

masknum = sum(mask)[0];

//cout << "\n  mask  " << masknum;

float rat;

rat = float(masknum) / mask.rows;

//cout << "\n  rat  " << rat;

if(best_num == 0 || Best_rat < rat)
{
  best_num = i;
  Best_rat = rat;
  Best_H = H;
  Best_match = matches;
  Best_des = desobj;
  Best_match_sub = good_matches;
  Best_key = keyobj;
  BestIm = next_c;

}
}

}

cout << " Stitching \n";

if(Best_rat < 0.1)
{
  cout << "No good matches \n";
  return 0;
}

//cout << "\n Best match size    " << Best_match_sub.size(); 
//// Starts Here ////
Mat H = Best_H/Best_H.at<double>(2,2);
Mat inv_H = H;

double tem_max_x, tem_max_y, tem_min_x, tem_min_y;
int y = BestIm.rows;
int x = BestIm.cols;
  Mat base_p1 = (Mat_<double>(1,3) << 0, 0, 1);
  Mat base_p2 = (Mat_<double>(1,3) << x, 0, 1);
  Mat base_p3 = (Mat_<double>(1,3) << 0, y, 1);
  Mat base_p4 = (Mat_<double>(1,3) << x, y, 1);
Mat tran;
Mat mult;
Mat base;
for (int i = 0; i <4 ; i ++ )
{
  if(i==0)
    base =base_p1;
  if(i == 1)
    base = base_p2;
  if(i == 2)
    base=base_p3;
  if(i == 3)
    base = base_p4;

transpose(base, tran);
mult = inv_H*tran;


tem_max_x = mult.at<double>(0) / mult.at<double>(2);
tem_max_y = mult.at<double>(1) / mult.at<double>(2);

if((max_x < tem_max_x) || (max_x == 999999))
  max_x = tem_max_x;
if((max_y < tem_max_y) || (max_y == 999999))
  max_y = tem_max_y;
if((min_x > tem_max_x))
  min_x = tem_max_x;
if((min_y > tem_max_y))
  min_y = tem_max_y;
}

if(min_x > 0)
  min_x =0;


if(min_y > 0)
min_y = 0;

//cout << " \n   max X     " << max_x  << "   max Y   " << max_y << "  min x  " << min_x << "   min y  " << min_y ;

Mat move_h = (Mat_<double>(3,3) << 1, 0, 0, 0, 1, 0, 0, 0, 1);

if(final_img.cols > max_x)
  max_x = final_img.cols;

if(final_img.rows > max_y)
  max_y = final_img.rows;

if ( min_x < 0 )
{
  move_h.at<double>(0,2) = move_h.at<double>(0,2) - min_x;
  max_x = max_x - min_x;
}

if ( min_y < 0 )
{
  move_h.at<double>(1,2) = move_h.at<double>(0,2) - min_y;
  max_y = max_y - min_y;
}

Mat mod_inv_h = move_h*inv_H;
int img_w = ceil(max_x);
int img_h = ceil(max_y);

Mat RR; 
warpPerspective(final_img, RR, move_h, cv::Size(5000,5000));
 cv::Mat result;
 warpPerspective(BestIm,result,mod_inv_h,cv::Size(5000,5000));
Mat rook= Mat::zeros( 5000, 5000, CV_8UC3 );
 Mat results = result;


for(int j=0; j<5000; ++j)
{
  for(int i=0 ; i <5000; ++i)
  {

  if (RR.at<cv::Vec3b>(j,i) == cv::Vec3b(0,0,0) && results.at<cv::Vec3b>(j,i) != cv::Vec3b(0,0,0))
      rook.at<cv::Vec3b>(j,i) = results.at<cv::Vec3b>(j,i);
    else
     rook.at<cv::Vec3b>(j,i) = RR.at<cv::Vec3b>(j,i);
  }
}

imwrite("Temp_Result.jpg", rook);
result = rook;
std::vector<cv::Point> nonBlackList;
nonBlackList.reserve(result.rows*result.cols);

    for(int j=0; j<result.cols; ++j)
        for(int i=0; i<result.rows; ++i)
        {
            if(result.at<cv::Vec3b>(j,i) != cv::Vec3b(0,0,0))
            {
                nonBlackList.push_back(cv::Point(i,j));
            }
        }

  std::vector<cv::Point> nonBlackListr;
    nonBlackList.reserve((result.rows)*(result.cols)); 
    int jm = 0, im =0;

    for(int j=0; j<(result.cols); ++j)
        for(int i=0; i<(result.rows); ++i)
        {
            if(result.at<cv::Vec3b>(j,i) != cv::Vec3b(0,0,0))
            {
              if(j > jm) 
                jm = j;
              if(i > im)
                im = i;
                
            }
        }


    for(int j=0; j<(result.cols); ++j)
        for(int i=0; i<(result.rows); ++i)
        {
            if(result.at<cv::Vec3b>(j,i) != cv::Vec3b(0,0,0))
            {
              if(i < im-10)
      nonBlackListr.push_back(cv::Point(i,j));
            }
        }  

    // create bounding rect around those points
    cv::Rect cc = cv::boundingRect(nonBlackListr);
    cv::Rect bb = cv::boundingRect(nonBlackList);
 if(result(bb).rows == img_w &&  result(bb).cols == img_h )
 {
  cout << "Can't stitch \n ";
  return 0;
 }
 
 imwrite( "Reult.jpg", result(bb) );


 //imwrite("wwwww.jpg", result(cc));



 final_img = result(cc);

vector<Mat> temp_img;
temp_img.push_back(final_img);
for (int i = 1; i < num; i++ )
if(i != best_num)
temp_img.push_back(image[i]);  
image = temp_img;


if (num-1<2)
  return 0;
else
{
stitch(num-1);
}
}


int main( int argc, char** argv )
{
/*
for (int i = 1; i < argc; ++i)
{
  cout << i << "  " << argv[i] << "\n";
img_names.push_back(argv[i]);

}
*/

open(argv[1]);

for (int i = 0; i < img_names.size(); ++i)
{
  cout << img_names[i] << " ";
}
/*
for (int i = 0; i < argc-1; ++i)
    { 
Mat tt = imread(img_names[i]);
image.push_back(tt);
}
*/

resizeImages((img_names.size()));
final_img = image[0];
int chhhh = stitch((img_names.size()));

return 0;


}