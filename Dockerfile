FROM centos:centos7

RUN yum install -y which xauth bzip2 curl

# get node
RUN curl -sL https://rpm.nodesource.com/setup_10.x | bash -
RUN yum update -y && yum install -y nodejs

RUN yum install -y  \
  pango.x86_64 \
  libXcomposite.x86_64 \
  libXcursor.x86_64 \
  libXdamage.x86_64 \
  libXext.x86_64 \
  libXi.x86_64 \
  libXtst.x86_64 \
  cups-libs.x86_64 \
  libXScrnSaver.x86_64 \
  libXrandr.x86_64 \
  GConf2.x86_64 \
  alsa-lib.x86_64 \
  atk.x86_64 \
  gtk3.x86_64 \
  ipa-gothic-fonts \
  xorg-x11-fonts-100dpi \
  xorg-x11-fonts-75dpi \
  xorg-x11-utils \
  xorg-x11-fonts-cyrillic \
  xorg-x11-fonts-Type1 \
  xorg-x11-fonts-misc \
  liberation-mono-fonts \
  liberation-narrow-fonts \
  liberation-sans-fonts \
  liberation-serif-fonts \
  dejavu-sans-fonts

RUN yum clean all

# Create app directory
WORKDIR /usr/src/app

COPY package.json package-lock.json ./

RUN npm install

COPY . .

CMD [ "node", "./repro.js" ]
