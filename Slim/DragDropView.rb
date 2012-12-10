#
#  DragDropView.rb
#  Slim
#
#  Created by Daniel Schmidt on 08.12.12.
#  Copyright 2012 Daniel Schmidt. All rights reserved.
#
class DragDropView < NSView
  
  attr_accessor :file, :dropState
  def initWithFrame(frame)
    @highlight = false
    if super
      registerForDraggedTypes [NSPDFPboardType, NSFilenamesPboardType]
    end
    self
  end
  
  def drawRect(rect)
    super
    if @highlight
      (NSColor.grayColor).set
      NSBezierPath.setDefaultLineWidth(5)
      NSBezierPath.strokeRect(self.bounds)
    end
  end

  def draggingEntered(sender)
    @highlight = true
    self.setNeedsDisplay(true)
    return NSDragOperationGeneric
  end

  def draggingExited(sender)
    @highlight = false
    self.setNeedsDisplay(false)
  end

  def prepareForDragOperation(sender)
    @highlight = false
    self.setNeedsDisplay(true)
    return true
  end

  def performDragOperation(sender)
    draggedFilenames = sender.draggingPasteboard.propertyListForType(NSFilenamesPboardType)
    if draggedFilenames.first.pathExtension.eql?("slim")
      return true
    else
      return false
    end
  end

  def concludeDragOperation(sender)
    draggedFilenames = sender.draggingPasteboard.propertyListForType(NSFilenamesPboardType)
    @file = draggedFilenames.first
    setDropStateImage("dropped")
  end
  
  def setDropStateImage(state="reset")
    bundle = NSBundle.bundleForClass(self.class)
    image_name = "iconmonstr-text-file-4-icon.png"
    if state.eql?("dropped")
      image_name = "iconmonstr-check-mark-10-icon.png"
    end
    image = NSImage.alloc.initWithContentsOfFile(bundle.pathForImageResource(image_name))
    dropState.setImage(image)
  end
    
  
end

