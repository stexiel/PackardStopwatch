from PIL import Image, ImageDraw, ImageFont
import os

# Create black and white icon with "Packard" text
sizes = [20, 29, 40, 60, 76, 83.5, 1024]
scales = [1, 2, 3]

output_dir = "PackardStopwatch/Assets.xcassets/AppIcon.appiconset"

for size in sizes:
    for scale in scales:
        if size == 1024 and scale > 1:
            continue
        
        pixel_size = int(size * scale)
        
        # Create black background
        img = Image.new('RGB', (pixel_size, pixel_size), color='black')
        draw = ImageDraw.Draw(img)
        
        # Try to load a font, fallback to default
        try:
            font_size = max(pixel_size // 8, 12)
            font = ImageFont.truetype("arial.ttf", font_size)
        except:
            font = ImageFont.load_default()
        
        # Draw "Packard" text in white
        text = "Packard"
        
        # Get text bounding box
        bbox = draw.textbbox((0, 0), text, font=font)
        text_width = bbox[2] - bbox[0]
        text_height = bbox[3] - bbox[1]
        
        # Center the text
        x = (pixel_size - text_width) // 2
        y = (pixel_size - text_height) // 2
        
        # Draw white text
        draw.text((x, y), text, fill='white', font=font)
        
        # Draw a simple border
        border_width = max(1, pixel_size // 50)
        draw.rectangle([0, 0, pixel_size-1, pixel_size-1], 
                      outline='white', width=border_width)
        
        # Save
        filename = f"icon_{int(size)}@{scale}x.png" if scale > 1 else f"icon_{int(size)}.png"
        img.save(os.path.join(output_dir, filename))
        print(f"Created {filename}")

print("All icons created!")
