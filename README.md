# MATLAB-Based Image Processing Protocol for Plant Disease Detection

## Overview

The workflow identifies diseased regions using HSV colour thresholding and calculates disease severity based on pixel counting.

----------------------------------------

## Requirements

MATLAB R2014 or later

Image Processing Toolbox

----------------------------------------

## Files

DiseaseDetection.m
Main MATLAB program

Sample_Images/
Example images

Output/
Example binary masks

----------------------------------------

## Installation

1. Download the repository.

2. Open MATLAB.

3. Open DiseaseDetection.m

4. Run the script.

5. Select an image when prompted.

----------------------------------------

## Input

RGB leaf image (.jpg, .png, .jpeg)

----------------------------------------

## Output

Original image

Binary disease mask

Healthy leaf mask

Disease area (pixels)

Leaf area (pixels)

Disease percentage (%)

----------------------------------------

## HSV Thresholds

Hue:
0.05–0.15

Saturation:
>0.20

Value:
0.20–0.85

These values were empirically selected under controlled illumination and may require adjustment for different plant species or imaging conditions.

----------------------------------------
