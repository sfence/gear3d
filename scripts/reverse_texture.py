#!/bin/python3

from PIL import Image
from PIL import ImageDraw
import sys

if (len(sys.argv)!=5):
  print("Usage: reverse_texture.py input_image output_image part_width part_height")
  exit();

step_width  = int(sys.argv[3])
step_height = int(sys.argv[4])

imgIn = Image.open(sys.argv[1]);

imgOut = Image.new(mode=imgIn.mode,size=(imgIn.size),color=(0,0,0,0));

width = imgIn.width
height = imgOut.height

if step_width==0:
  step_width = width
if step_height==0:
  step_height = height

for x in range(0,imgIn.width,step_width):
  for y in range(0,imgIn.height,step_height):
    mask = Image.new("L", size=imgIn.size, color=0)
    draw = ImageDraw.Draw(mask)
    
    draw.rectangle((x, y, x+step_width-1, y+step_height-1), fill=255)
    imgOut.paste(imgIn, (width-step_width-2*x, height-step_height-2*y), mask)
    #imgOut.paste(imgIn, (-100, 0), mask)

imgOut.save(sys.argv[2])

