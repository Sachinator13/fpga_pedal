import numpy as np
from scipy.io import wavfile
from pathlib import Path

# === PATHS ===
base_dir = Path(__file__).parent
mem_dir = base_dir / "memorytesting"

input_wav = base_dir / "clapping.wav"
output_mem = mem_dir / "data.mem"
meta_file = mem_dir / "meta.txt"

# === LOAD WAV ===
samplerate, data = wavfile.read(input_wav)

# Convert stereo to mono if needed
if len(data.shape) > 1:
    data = data.mean(axis=1).astype(np.int16)

# Make sure memory_testing folder exists
mem_dir.mkdir(exist_ok=True)

# Save HEX memory file
with open(output_mem, 'w') as f:
    for sample in data:
        f.write(f"{int(sample) & 0xFFFF:04X}\n")

# Save sample rate
with open(meta_file, 'w') as f:
    f.write(str(samplerate))

print(f"✅ WAV to .mem conversion complete.")
print(f"➡️  Saved to {output_mem}")
