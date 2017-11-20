#include "opencv2/core/core.hpp"
#include "opencv2/imgproc/imgproc.hpp"
#include "opencv2/highgui/highgui.hpp"
#include "opencv2/imgproc/imgproc_c.h"
#include <iostream>
#include "opencv/cv.h"
#include "opencv2/ml/ml.hpp"
#include <stdio.h>

using namespace std;
using namespace cv;
vector<string> color;
vector<string> type;
vector<int> numcar;
std::ostringstream filna;


void cvImfill(IplImage * I)
{   //Fills the holes (black) in the Image
    IplImage* fill=cvCreateImage(cvSize((I->width+2), (I->height+2)), I->depth, 1);   // Create an image with one pixel border more than that of input image
    cvSet(fill,cvScalar(0),NULL);                                                     // Fill the image with zeros
    cvSetImageROI(fill, cvRect(1, 1, (I->width), (I->height)));                       // Set the ROI to make a copy input image
    cvCopy(I,fill,NULL);                                                              // Make a copy of input image
    cvResetImageROI(fill);                                                            // Reset ROI. THis results in an image with a border to input image
    CvConnectedComp comp;                                                             // Initialize connected component for using in FloodFill function.( Not necessary)
    double A,B;                                                                       // Initialize variables for finding location of any minimum intensity (0) pixel in image
    double *a,*b; a=&A;b=&B;
    CvPoint P;
    CvPoint* p; p= &P;
    IplImage* ref= cvCloneImage(fill);                                                // Make a copy of image fill
    cvMinMaxLoc(ref,a,b,p,NULL,NULL);                                                  // Find a location of minimum intensity in the image, the location obtained can be used as seed point in Flood fill
    cvFloodFill(fill,P,cvScalar(255),cvScalar(0),cvScalar(250),&comp,( 8 | CV_FLOODFILL_FIXED_RANGE),NULL); //Flood fill the image. This fills background of input image
    cvNot(fill,fill);                                                                  // This converts the holes present in image to foreground pixels
    cvSetImageROI(fill, cvRect(1, 1, (I->width), (I->height)));                        //Set ROI of fill image
    cvSetImageROI(ref, cvRect(1, 1, (I->width), (I->height)));                         // set ROI of ref image which is a copy of fill
    cvOr(fill,ref,I,NULL);                                                             // Perform OR operation on the individual pixels. This ensures that foreground objects are retrieved and the holes are filled. Store the result in input image
    cvResetImageROI(fill);                                                             //Reset Image ROI's of Both the intermediate images used
    cvResetImageROI(ref);
}


int main(int argc, char *argv[])
{
    cv::VideoCapture check(argv[1]);                     //Check for video object input
    int numf = check.get(CV_CAP_PROP_FRAME_COUNT);       //Get the Frame count of video
    int fps = check.get(CV_CAP_PROP_FPS);                //Get the FPS of video
    int ff = numf;
    numf--;
    cvNamedWindow("Camera_Output");
    cvNamedWindow("Frame Difference");
    cvNamedWindow("Object Detection");
    cvNamedWindow("Reference Image");
    cvNamedWindow("Threshold Image");
    IplConvKernel* strel_rec=cvCreateStructuringElementEx(11,11,NULL,NULL,CV_SHAPE_RECT,NULL); //Initialize a square structuring element of side length 11
    IplConvKernel* strel_Crec=cvCreateStructuringElementEx(25,45,NULL,NULL,CV_SHAPE_RECT,NULL);//Initialize a Rectangle structuring element of size 25x45
    IplConvKernel* strel_Hline=cvCreateStructuringElementEx(3,41,1,20,CV_SHAPE_RECT,NULL);      //Initialize a Rectangle structuring element of size 3x41
    IplConvKernel* strel_Vline=cvCreateStructuringElementEx(41,3,20,1,CV_SHAPE_RECT,NULL);      //Initialize a Rectangle structuring element of size 41x3
    CvCapture* capture = cvCreateFileCapture(argv[1]);                                          //Initialize the video object
    IplImage* F1 = cvCreateImage(cvSize(320,240),IPL_DEPTH_8U, 3);                              //Initialize an image of size 320x240 , 8 bit depth, 3 channel image
    //    IplImage* F2 = cvCreateImage(cvSize(320,240),IPL_DEPTH_8U, 3);
    IplImage* grayframe1 = cvCreateImage(cvSize(320,240),IPL_DEPTH_8U, 1);                      //Initialize an image of size 320x240 , 8 bit depth, 1 channel image
    IplImage* grayframe2 = cvCreateImage(cvSize(320,240),IPL_DEPTH_8U, 1);                      //Initialize an image of size 320x240 , 8 bit depth, 1 channel image
    IplImage* sub = cvCreateImage(cvSize(320,240),IPL_DEPTH_8U, 1);                             //Initialize an image of size 320x240 , 8 bit depth, 1 channel image
    //  IplImage* Cont = cvCreateImage(cvSize(320,240),IPL_DEPTH_8U, 1);
    cvZero(grayframe2);                                                                         //Fill the image grayframe2 with zeros
    //*****************  initialize the variables for counting *********************
    int hhh ;
    int prevcount=0;
    int totalVehicle=0;
    int currentcount=0;
    int repeatcount=0;
    int detect = 0;
    int st = 0;
    int rr=0;
    int bb=0 ;
    int gg= 0;
    int numfra = 0;
    int fram =0;
    int predect =0;
    int cc = 0 ;
    double pparr = 1;
    double area;
    int point = 0;
    double prevarea = 0;
    string ty;            //string for the type of image
    string ccol ;         // string for the colour of image
    CvSeq* contour=NULL;  // Initialize variable for contour
    CvMemStorage* storage= cvCreateMemStorage(0); // Initialize pointer for memory storage
    IplImage* frame1, *frame2,*Ref;
    CvPoint* VCount,Point;
    VCount=&Point;
    //   CvPoint P=cvPoint(0,0);
    // IplImage  *Iref;
    int k=0;
    cout << "\n " << fps;
    //*********************************** Algorithm for vehicle detection *************************
    while(numf > 0)                           //Continue till all the frames in video are read
    {
        numf--;                               // Decrement frame counter
        // cout << numf << "\n";
        frame1=cvQueryFrame(capture);         // Grab the frame from video object
        cvResize(frame1,F1,CV_INTER_LINEAR);  // Resize the frame into 320x240 image. This is considered to be base image for further processing
        uchar* Idata=(uchar*)F1->imageData;   // Declare data ptr for base image
        cvShowImage("Camera_Output", F1);     //Show image on created window
        cvCvtColor(F1,grayframe1,CV_BGR2GRAY);// Convert the image into Gray scale
        cvShowImage("Reference Image",grayframe2);
        cvAbsDiff(grayframe1,grayframe2,sub);  // Perform subtraction on the consecutive frames
        cvShowImage("Frame Difference",sub);
        cvThreshold(    sub,    sub,    40,    255,    CV_THRESH_BINARY ); //Threshold the image to remove unwanted noise due to illumination effects in subtraction of frames
        cvShowImage("Threshold Image",sub);
        
        //************************ Morphological operations on frame difference to enhance the foreground object, i.e, the vehicle***************/
        cvSmooth(sub,sub,CV_MEDIAN,3,3,0,0);    //smoothen the image using median filter. This removes impulse noise in the image less than or equal to the size of it's kernel.i.e, 3x3
        cvDilate(sub,sub,strel_Hline,1);        // Dilate the image using rectangle of more width and less height. This enhances horizontal borders of vehicle in the image
        cvDilate(sub,sub,strel_Vline,1);        // Dilate the image using rectangle of more height and less width.This enhances vertical borders of vehicle in the image
        cvErode(sub,sub,strel_rec,1);           //Smoothen the contour of the object by successive erosion and dilation with a square and rectangular structural elements respectively
        cvDilate(sub,sub,strel_Crec,1);
        cvImfill(sub);                          //Fill the holes if any formed in the object.This ensures that object is formed as a complete and smooth blob
        //************************* Contour Detection and further processing*********************************************************************/
        if(k>0)
        {
            IplImage* image=cvCloneImage(sub);                                //make a copy of image for further processing
            CvContourScanner Scan_contour=cvStartFindContours(image,storage,sizeof(CvContour),CV_RETR_LIST,2,cvPoint(0,0)); //Retrieve the sequence of contours present in image
            while(( contour= cvFindNextContour(  Scan_contour )) !=NULL)       //While the contours left to be checked are not NULL continue processing on each contour in image
            {
                area= cvContourArea(contour, CV_WHOLE_SEQ );                  //Compute the area of each contour
                if(area > 15000 )  //12500                                    //Perform further processing on the current contour only if it's size is greater than a prescribed value. This does "size filtering"
                {
                    if(area > 30000)                                          //If the contour found is large enough that can belong to a vehicle, perform further processing
                        fram++;
                    
                    currentcount++;                                          // Increment the contour count number
                    CvRect Rect=cvBoundingRect(contour,1);                   // Find the bounding box for the current contour
                    CvRect* Rect_ptr=&Rect;
                    //****** extraxt the details of the bounding box *******
                    int bb_x=Rect_ptr->x;
                    int bb_y=Rect_ptr->y;
                    int bb_width=Rect_ptr->width;
                    int bb_height=Rect_ptr->height;
                    if( 140 < (bb_height-bb_x) < 180)                        // If the object lies in the middle portion of the frame perform further process
                    {
                        cvRectangle(F1,cvPoint(bb_x,bb_y),cvPoint(bb_x+bb_height,bb_y+bb_width),cvScalar(0,0,255),1); // Draw a bounding box to the current contours
                        cvShowImage("Camera_Output", F1);	cvWaitKey(1);                                             //Update and display the frame with detected contours
                        //***********Extract the colour components from the frame ************************
                        int blue= Idata[(bb_x+(bb_height))*F1->widthStep+(bb_y+bb_width/2)];
                        int green= Idata[(bb_x+(bb_height))*F1->widthStep+(bb_y+bb_width/2)+1];
                        int red= Idata[(bb_x+(bb_height))*F1->widthStep+(bb_y+bb_width/2)+2];
                        
                        
                       // cout << "\n  Blue  " << blue  << "   Green  " << green << "  Red   " << red;
                        
                        if(blue > 30 || red > 30 || green > 30)
                        {
                            bb += blue;
                            gg += green;
                            rr += red;
                            numfra++;
                        }
                        
                        
                    }
                    
                    
                    pparr = area;
                    
                    
                    
                    
                }
                
                //   cout << " \n  count here "  << currentcount;
            }
            
            if (currentcount == 2)
                point = 1;
            
            //    cout << "\n repeat  " << repeatcount;
            if(repeatcount > 15 && detect == 0)
            {
                
                
                //    cout << "\n pra  " << prevarea << "    "  << pparr;
                
                //   cin >> hhh;
                if (prevarea > pparr+1000)
                    
                {
                    //      cout << "\n here \n";
                    totalVehicle+=1;
                    repeatcount=0;
                    prevcount =0;
                    detect = 1;
                    predect = 1;
                    
                    
                    
                    /// Here we push the type of vehicle ///
                    
                    // Store frames  //
                    char filename[80];
                    char tempim[80];
                    
                    
                    sprintf(filename,"Car_%d.jpg",totalVehicle);
                    sprintf(tempim,"TempCar_%d.jpg",totalVehicle);
                    cvSaveImage(filename, frame1);
                    cvSaveImage(tempim, F1);
                    
                    
                    
                    
                    
                }
                else {
                    prevarea = pparr;
                }
            }
            else if(currentcount == prevcount && currentcount != 0)
            {
                repeatcount+=1;
                prevarea = pparr;
                
            }
            
            
            if (currentcount == 0 && point == 0)
            {
                repeatcount = 0;
                detect = 0;
            }
            
            if (predect == 1 && detect == 0)
            {
                if (fram == 0)
                    fram =1;
                
                string color;
                if (fram >  95)
                    ty = "Big Car";
                else
                    ty = "Small car";
                
                if((bb/fram) < 80 && (gg/fram) < 80 && (rr/fram) < 80)
                    color = "black";
                
                else if((bb/fram) > 100 && (gg/fram) > 100 && (rr/fram) > 100)
                    color = "white";
                
                else if((bb/fram) > (gg/fram) && (bb/fram) > (rr/fram) )
                    color = "blue";
                
                else if((rr/fram) > (gg/fram) && (rr/fram) > (bb/fram) )
                    color = "blue";
                
                else if((gg/fram) > (rr/fram) && (gg/fram) > (bb/fram) )
                    color = "green";
                
                
                printf("\n Vehiclecount %d  , type %s, Color %s , Color (Blue, Red, Green) (%d  ,%d  ,%d  )  \n",totalVehicle, ty.c_str(), color.c_str(), (bb/fram),(rr/fram),(gg/fram));
                
                bb = 0;
                rr=0;
                gg=0;
                numfra=0;
                fram=0;
                predect=0;
                st =1;
                
                if (point == 1)
                    point = 0;
                
                
            }
            if (currentcount == 0)
            {
                repeatcount = 0;
                detect = 0;
                bb = 0;
                rr=0;
                gg=0;
                numfra=0;
                point =0;
            }
            
            //          printf("     Car count %d , area %f ,Vehiclecount %d\n",currentcount,area,totalVehicle);
            prevcount=currentcount;
            
            
            
            currentcount=0;
            area = 0;
            cvClearMemStorage(storage);
        }
        
        cvShowImage("Object Detection",sub);
        cvCopy(grayframe1,grayframe2,NULL);
        cvWaitKey(1);
        k++;
	   }
    
    
    
    cvReleaseCapture(&capture); //Release capture.
    
    return 0;
}


