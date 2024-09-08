FROM ruby:3.2.0

RUN curl -fsSL https://deb.nodesource.com/setup_22.x | bash - && \
    apt-get install -y nodejs default-mysql-client

RUN npm install -g yarn

WORKDIR /app

COPY Gemfile /app/Gemfile
COPY Gemfile.lock /app/Gemfile.lock
RUN bundle install

COPY package.json /app/
COPY yarn.lock /app/
RUN yarn install

COPY . /app

RUN yarn vite build