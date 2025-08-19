import numpy as np
from scipy.io import wavfile
from pathlib import Path

# === PATHS ===
base_dir = Path(__file__).parent
mem_dir = base_dir / "memorytesting"

input_mem = mem_dir / "output.mem"
meta_file = mem_dir / "meta.txt"
output_wav = base_dir / "reconstructed.wav"

# === READ SAMPLE RATE ===
with open(meta_file, 'r') as f:
    samplerate = int(f.read().strip())

# === LOAD HEX FILE ===
with open(input_mem, 'r') as f:
    lines = f.readlines()[3:]  # skip first 3 lines

samples = []
for line in lines:
    hex_str = line.strip()
    if hex_str:
        val = int(hex_str, 16)
        if val >= 0x8000:
            val -= 0x10000
        samples.append(val)

samples = np.array(samples, dtype=np.int16)

# === SAVE .WAV ===
wavfile.write(output_wav, samplerate, samples)

print(f"✅ .mem to WAV conversion complete.")
print(f"➡️  Output: {output_wav}")
