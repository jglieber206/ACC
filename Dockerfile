FROM phusion/passenger-ruby21
ADD . /home/app
WORKDIR /home/app
RUN bundle install
RUN npm install
CMD ["bundle","exec", "thin", "start", "-p", "9292"]
EXPOSE 9292
