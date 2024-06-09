FROM python:3.6-alpine
MAINTAINER alexzaza17"bernardtapi1702@gmail.com"
WORKDIR /opt
COPY ./  /opt/src/
# Install Flask
RUN pip install flask
# Set Odoo URL environment variable
ENV ODOO_URL="https://odoo.com"
# Set pgAdmin URL environment variable
ENV PGADMIN_URL="https://pgadmin.org"
#ENV ODOO_URL=1
#ENV PGADMIN_URL=1
#RUN pip3 install 
EXPOSE 8080
ENTRYPOINT ["python", "/opt/src/app.py"]
