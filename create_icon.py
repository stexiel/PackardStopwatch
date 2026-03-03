from PIL import Image
import os

# Create icons from logo
sizes = [20, 29, 40, 60, 76, 83.5, 1024]
scales = [1, 2, 3]

output_dir = "PackardStopwatch/Assets.xcassets/AppIcon.appiconset"

# Load the logo
logo = Image.open("packard_logo.jpg")

for size in sizes:
    for scale in scales:
        if size == 1024 and scale > 1:
            continue
        
        pixel_size = int(size * scale)
        
        # Resize logo to fit icon size
        resized_logo = logo.resize((pixel_size, pixel_size), Image.Resampling.LANCZOS)
        
        # Convert to RGB if needed
        if resized_logo.mode != 'RGB':
            resized_logo = resized_logo.convert('RGB')
        
        # Save
        filename = f"icon_{int(size)}@{scale}x.png" if scale > 1 else f"icon_{int(size)}.png"
        resized_logo.save(os.path.join(output_dir, filename))
        print(f"Created {filename}")

print("All icons created!")
