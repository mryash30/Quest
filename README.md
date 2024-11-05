---

# **Rearc/Quest**

## **Project Overview**

The project, **Quest**, is a web application built using **Node.js** and **Golang**. The webapp is hosted on **AWS ECS** and deployed using a containerization approach with **Docker**. The infrastructure is configured with an **AWS Load Balancer**, and the entire setup is provisioned using **Terraform**, with configuration files stored in **Git** for version control.

The main objective of this project is to find a **secret word**, which is then set as an **environment variable** in the Docker container. This environment variable is crucial for confirming the success of the deployment. Upon deployment, the presence of the secret word in the container will validate whether the deployment was successful.

This setup leverages modern DevOps practices, combining infrastructure as code, containerization, and cloud services to automate and streamline the deployment process.

---

## **Thought Process and Approach**

### **Initial Research and Planning**

When I first started this project, I began by understanding the requirements and defining the scope of the application. The goal was clear: A simple web application using Node.js and Golang is given, and it needs to be deployed to the cloud using AWS ECS, with containerization via Docker. I also needed a method to verify the deployment by using an environment variable (the secret word) to confirm the deployment's success.

### **Choosing Technologies**

- **Selected AWS as the cloud provider**:  
  AWS is widely regarded as the most popular and reliable cloud platform in the market. It offers a broad range of services with excellent scalability, security, and flexibility, making it an ideal choice for hosting the web application. AWS also provides comprehensive tools for container orchestration and deployment, which aligned well with the project's needs.

- **Chose Terraform for Infrastructure-as-Code (IaC)**:  
  I decided to use Terraform to manage the infrastructure. Terraform allows you to define and provision resources using declarative configuration files, ensuring repeatability, consistency, and version control of the infrastructure. This was essential for maintaining an organized, auditable, and scalable setup. Terraform enabled me to define key components like the VPC, ECS Cluster, Application Load Balancer, and security groups, all in code that could be versioned, shared, and easily modified.

- **Opted for Docker for containerization**:  
  Docker was chosen to package the application and its dependencies into containers. This ensures the application runs consistently across different environments (local, staging, production). Since the application would be hosted on AWS ECS, Docker's native compatibility with ECS made it a natural choice for deployment. Using Docker simplifies container management, allows for easy scaling, and streamlines deployment across various environments.

Overall, my initial research and planning focused on choosing the best tools and technologies that would provide a scalable, reliable, and manageable infrastructure for the web app. The combination of AWS, Terraform, and Docker provided a solid foundation for both development and deployment.

---

## **Infrastructure Setup**

To set up the infrastructure for the web application, I used Terraform to automate and define the necessary AWS resources. The following steps outline the process:

1. **Create a separate VPC (Virtual Private Cloud)**:  
   I provisioned an isolated network environment specifically for the web app. This ensured that the resources were securely segregated from other projects and provided full control over networking configurations such as subnets and routing tables.

2. **Set up an Application Load Balancer (ALB)**:  
   I configured an ALB to distribute incoming web traffic to the ECS containers. The ALB helps balance the load across multiple containers, improves fault tolerance by distributing traffic across different availability zones, and enhances application availability.

3. **Create an Auto Scaling Group (ASG)**:  
   I created an Auto Scaling Group for automatic scaling of EC2 instances that would run the web app in Docker containers. The ASG is provisioned alongside the ECS cluster, ensuring that the application can scale based on demand. This setup also provides better control over future modifications, as well as improved monitoring and alerting capabilities for the infrastructure.

4. **Provision AWS ECS (Elastic Container Service)**:  
   I created an ECS Cluster where the application containers would run. I also defined an ECS Task Definition, which specified the Docker image to use, as well as environment variables and resource limits for the containers. This allowed for easy and scalable container management.

5. **Configure Security Groups and IAM Roles**:  
   I set up security groups to control access to the various resources, defining allowed inbound and outbound traffic for the ECS instances and Load Balancer. Additionally, I configured IAM roles to ensure proper permissions for the ECS instances to access necessary AWS resources, while keeping security tightly controlled.

By using Terraform, I ensured that all infrastructure components were version-controlled, making the entire environment easy to manage and modify. After provisioning the resources, I tested the setup by deploying simple test containers to ECS and verifying that the Load Balancer correctly routed traffic to the containers. This confirmed that the infrastructure was properly configured and functional.

---

## **Application Deployment**

The next step was to deploy the web application using Docker on AWS ECS. First, I created a Dockerfile to package and deploy the Node.js application. This Dockerfile defined the necessary instructions for setting up the environment, installing dependencies, and running the app. Once the Dockerfile was created, I built the Docker image and pushed it to an ECR (Elastic Container Registry) repository, making it available for AWS ECS to pull and deploy.

After the Docker image was successfully stored in ECR, I focused on a critical task: retrieving and using the secret word. This secret word would serve as a flag to confirm the deployment's success. I decided to set this secret word as an environment variable in the Docker container. To achieve this, I updated the Dockerfile to include the environment variable. This ensured that when the container was launched, the secret word was available inside the container as an environment variable.

Once the environment variable was added to the Dockerfile, I redeployed the application to ECS, ensuring the updated container with the secret word was being used. After the deployment was complete, I verified the successful deployment by checking that the container correctly read the secret word, confirming that the application had been deployed successfully.

---

## **Notes and Additional Information**

- **Terraform Workspaces**:  
  I used Terraform Workspaces to manage multiple environments (e.g., development, staging, production) within a single Terraform configuration. This allowed me to isolate configurations and manage separate state files for each environment, ensuring a clear separation of resources and minimizing the risk of conflicts across different environments.

- **Remote State Management**:  
  To facilitate better collaboration among the team, I stored the Terraform state file remotely in an encrypted S3 bucket. This ensured that the state file was securely managed and accessible by all team members. Storing the state remotely also enabled versioning and automated locking to prevent concurrent modifications and ensure consistency across deployments.

- **Multiple State Files**:  
  For improved management and to avoid unintended dependencies, I used multiple state files for different parts of the infrastructure. This approach allowed me to isolate the state of various resources (e.g., VPC, ECS, Load Balancer) into separate state files. By doing this, changes made to one resource did not affect the others, providing more control and reducing the risk of breaking the infrastructure when updating or modifying individual components.

- **Using YAML for Configuration**:  
  Instead of variables.tf and .tfvars files, YAML was used for a cleaner and more manageable configuration, providing better readability and maintainability.

---

## **Challenges Faced**

- **Infrastructure Complexity**:  
  Setting up AWS ECS with Docker containers and an Application Load Balancer (ALB) was complex, especially when configuring security groups and IAM roles to ensure the correct permissions. It took some time to understand the fine-grained access control required for the ECS tasks to interact properly with the Load Balancer and other AWS resources. Ensuring the containers could communicate securely across different components while maintaining least-privilege principles for security was a challenge.

- **State Management with Terraform**:  
  Managing state files across different environments using Terraform Workspaces added another layer of complexity. While Terraform’s workspace functionality helped with environment isolation, I encountered challenges when ensuring the remote S3 bucket state management worked seamlessly across teams. Issues such as lock contention during concurrent changes or syncing remote state with local configurations had to be carefully managed. Additionally, using multiple state files for different parts of the infrastructure required additional planning to prevent accidental overwrites and to ensure proper isolation of components.

---

## **Future Improvements**

- **Scalability**:  
  Implement auto-scaling based on CPU and memory usage to handle traffic spikes. Optimize Docker containers by reducing image size and refining dependencies. Explore AWS Fargate for serverless container management.

- **Monitoring & Alerts**:  
  Integrate AWS CloudWatch to monitor the application in real-time and set up CloudWatch Alarms for performance and resource alerts. Implement log aggregation using CloudWatch Logs or the EFK stack.

- **Security**:  
  Enable HTTPS with SSL/TLS certificates and ensure data encryption in transit and at rest. Refine IAM roles and access control, and integrate AWS WAF for better protection.

- **CI/CD Pipeline**:  
  Set up a CI/CD pipeline using Jenkins to automate the build, test, and deployment process, ensuring faster and more reliable updates.

- **Infrastructure Optimization**:  
  Modularize the Terraform configuration for better scalability and explore using AWS Systems Manager Parameter Store or Secrets Manager to securely store sensitive information.

- **Disaster Recovery & Backup**:  
  Implement a disaster recovery plan and multi-region deployments to ensure better availability and fault tolerance. Set up automated backups for critical data.

- **Cost Optimization**:  
  Review AWS cost structures, use Reserved Instances or Spot Instances, and optimize ECS and Docker resource allocations to reduce costs while maintaining performance.



---

## **Conclusion**

This project successfully demonstrated how to deploy a containerized web application using Node.js, Golang, AWS ECS, and Docker, with infrastructure managed by Terraform. The use of modern DevOps practices allowed for an automated, scalable, and reliable deployment pipeline, and there are numerous opportunities for future improvements, including enhanced scalability, security, and monitoring.

Application is live on this url: http://quest-dev-ue1-public-alb-873129906.us-east-1.elb.amazonaws.com/

--- 