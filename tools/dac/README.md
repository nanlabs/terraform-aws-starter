# 📊 Diagram as Code Scripts

This directory contains scripts to generate infrastructure diagrams using Python.

## 🚀 Getting Started

### Prerequisites

Ensure you have the following installed:

- Python (managed by `pyenv`)
- `pyenv`
- `pipenv`

### 📂 Project Structure

```
.
├── live_core.py         # Diagram as Code script for live production infrastructure
├── Pipfile              # Pipenv configuration file
├── Pipfile.lock         # Pipenv lock file
└── .python-version      # Python version file managed by pyenv
```

### 🔧 Setup Instructions

1. **Install `pyenv`**:

   ```sh
   curl https://pyenv.run | bash
   ```

   Follow the instructions to add `pyenv` to your shell.

2. **Install the required Python version**:

   ```sh
   pyenv install
   pyenv local
   ```

3. **Install `pipenv`**:

   ```sh
   pip install --user pipenv
   ```

4. **Create and activate a virtual environment using `pipenv`**:

   ```sh
   pipenv install
   pipenv shell
   ```

5. **Install project dependencies**:

   ```sh
   pipenv install --dev
   ```

### 📜 Usage

To generate the infrastructure diagram, run the following command inside the `pipenv` shell:

```sh
python live_core.py
```

This will create a diagram of the live production infrastructure, showcasing the relationships between different AWS components.

### 📦 Dependencies

This project relies on the following Python packages:

- `diagrams`
- Other dependencies specified in `Pipfile`
