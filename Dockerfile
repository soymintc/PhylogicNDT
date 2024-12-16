FROM python:3.8-slim

# Install required system dependencies
RUN apt-get update && apt-get install -y \
    build-essential \
    r-base \
    r-base-dev \
    git \
    graphviz \
    python3-tk \
    libgraphviz-dev \
    libfreetype6-dev \
    libpng-dev \
    libqhull-dev \
    && apt-get clean

# Install pip and set up older NumPy
RUN pip install --upgrade pip setuptools==59.8.0 wheel
RUN pip install intervaltree scikit-learn networkx seaborn
RUN pip install numpy==1.19.5  # Older NumPy version compatible with older C APIs

# Install required Python packages
RUN pip install pandas==1.1.5 scipy==1.5.4 matplotlib==3.3.4

# Install GitHub packages
RUN pip install -e git+https://github.com/garydoranjr/pyemd.git#egg=emd
RUN pip install -e git+https://github.com/rmcgibbo/logsumexp.git#egg=sselogsumexp

# Install the R package 'plyr'
RUN R -e "install.packages('plyr', repos = 'http://cran.us.r-project.org')"

# Create the application directory and copy necessary files
RUN mkdir /phylogicndt/
COPY PhylogicSim /phylogicndt/PhylogicSim
COPY GrowthKinetics /phylogicndt/GrowthKinetics
COPY BuildTree /phylogicndt/BuildTree
COPY Cluster /phylogicndt/Cluster
COPY SinglePatientTiming /phylogicndt/SinglePatientTiming
COPY LeagueModel /phylogicndt/LeagueModel
COPY data /phylogicndt/data
COPY ExampleData /phylogicndt/ExampleData
COPY ExampleRuns /phylogicndt/ExampleRuns
COPY output /phylogicndt/output
COPY utils /phylogicndt/utils
COPY PhylogicNDT.py /phylogicndt/PhylogicNDT.py
COPY LICENSE /phylogicndt/LICENSE
COPY req /phylogicndt/req
COPY README.md /phylogicndt/README.md
