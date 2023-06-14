import 'package:firebase_auth/firebase_auth.dart';

String? uId;

User? userConst;

const String help_hr = """
\na. Editing HR details: To edit HR details, go to the menu and click on "edit hr ". Here, you can edit the name, email, and contact information of the HR representative.
\nb. Editing company details: To edit company details, go to the menu and click on "edit company details". Here, you can edit the name, logo, and description of the company.
\nc. Posting a job: To post a job, go to the navigation bar and click on "Post Job". Fill in the required details, such as job title, description, and requirements.
\nd. Reviewing applications: To review applications, go to the job you want to see who applied for it and click see job applications button. 
\ne. Accepting or rejecting applications: To accept or reject an application, after clicking on the application you will have option to review the cv you have two options either to accept or reject, if accepted the hr will schedule an interview date if rejected he will write feedback for the rejected applicant.
\nf. Interview notes: To take interview notes it will be one of he 3 options will appear to the hr when he clicked on a certain job application. Click on the interview notes and you will see a notes section where you can write down your thoughts about the applicant.
\ng. Final report: After making a decision on an application, you can send a final report to the applicant. To do this, when you clicked on a certain job application there will be 3 options appear to the hr. Click on the final report and you will see a notes section where you can write down your final report about the applicant after the interview
""";
const String help_applicant = """
\na. Creating your CV: After creating your account the first feature will appear to the applicant is to create a CV, click on the Create CV button and fill in the required information, such as your personal details, work experience, education, and skills.
\nb. Editing your CV: To edit your CV, click on the Edit CV button from menu and make the necessary changes.
\nc. Searching for jobs: To search for jobs, go to the Job List and enter a job title or category in the search bar. You can also filter job listings by location, salary, and other parameters.
\nd. Applying for a job: To apply for a job, go to the "Job Listings" section and click on the job you're interested in. Then, click on the "Apply" button and upload your CV.
\ne. Checking application status: To check the status of your application, go to the "Applications status " in navigation bar and you will see the status of each application you have submitted.
\nf. Viewing interview date: If your application is accepted, you will be able to view the interview date.
\ng. Receiving feedback: If your application is rejected, you will receive feedback from the company.
\nh. Saving jobs for later: To save a job for later, click on the "Save for Later" button in the job listing.
\ni. Interview tips: To help you prepare for your job interview, here are some tips:
\t\n1.Research about the company: Before your interview, take some time to research the company you're applying to. This can help you understand their values, mission, and culture. You can also use this information to tailor your answers to the interviewer's questions.
\t\n2.Practice common interview questions: There are many common interview questions that most employers ask, such as "What are your strengths and weaknesses?" and "Why do you want to work here?" Practice answering these questions with a friend or family member to help you feel more confident and prepared.
\t\n3.Dress appropriately: Dress professionally for your interview, even if the company has a more casual dress code. This shows that you take the interview seriously and respect the interviewer's time.
\t\n4.Arrive on time: Plan to arrive at least 10-15 minutes early to your interview. This gives you time to find the location, check in with the receptionist, and calm your nerves.
\t\n5.Be prepared to talk about your experience: Be ready to discuss your previous work experience and how it relates to the position you're applying for. Use specific examples to demonstrate your skills and accomplishments.
\t\n6.Ask questions: Prepare some questions to ask the interviewer about the company or the position. This shows that you are interested in the job and have done your research.
\t\n7.Stay positive: Stay positive throughout the interview, even if you feel nervous or unsure of yourself. Smile and maintain good eye contact with the interviewer. This helps to build a rapport and establish a positive connection.
\t\n8.Follow up after the interview: After the interview, send a thank you email or note to the interviewer. This shows your appreciation for their time and reiterates your interest in the position.
""";

String defaultDropDownListValue = "--Select--";

List<String> citiesList = [
  "--Select--",
  "Cairo",
  "Alexandria",
  "Gizeh",
  "Shubra El-Kheima",
  "Port Said",
  "Suez",
  "Luxor",
  "al-Mansura",
  "El-Mahalla El-Kubra",
  "Tanta",
  "Asyut",
  "Ismailia",
  "Fayyum",
  "Zagazig",
  "Aswan",
  "Damietta",
  "Damanhur",
  "al-Minya",
  "Beni Suef",
  "Qena",
  "Sohag",
  "Hurghada",
  "6th of October City",
  "Shibin El Kom",
  "Banha",
  "Kafr el-Sheikh",
  "Arish",
  "Mallawi",
  "10th of Ramadan City",
  "Bilbais",
  "Marsa Matruh",
  "Idfu",
  "Mit Ghamr",
  "Al-Hamidiyya",
  "Desouk",
  "Qalyub",
  "Abu Kabir",
  "Kafr el-Dawwar",
  "Girga",
  "Akhmim",
  "Matareya"
];
List<String> countriesList = [
  "--Select--",
  "United States",
  "Canada",
  "Afghanistan",
  "Albania",
  "Algeria",
  "American Samoa",
  "Andorra",
  "Angola",
  "Anguilla",
  "Antarctica",
  "Antigua and/or Barbuda",
  "Argentina",
  "Armenia",
  "Egypt"
];
List<String> jopTitlesList = [
  "--Select--",
  "IT",
  "front end web Developer",
  "Web Developer",
  "Integration",
  "IT Application Integration Technology Technical Manager",
  "full stack intern",
  "Embedded Software Engineer",
  "SaaS AI invoicing & estimate platform - Contractors",
  "Azure Synape Microsoft Arthitect/Engineer",
  "Core-java-tutor",
  "UI/UX designer",
  "Finance",
  "Business Systems Analyst",
  "Permanent Part-Time Sales Assistant",
  "Sales Assistant",
  "Finance Assistance",
  "Sales Consultant at Liberty",
  "accountant",
  "Internal Sales",
  "Client Services Store Co-ordinator",
  "Group Marketing Manager",
  "Medicine",
  "medical senior officer",
  "Quayside Superintendent",
  "patient safety specialist",
  "medical representative",
  "Other",
  "Recruitment Specialist"
      "Driver",
  "receptionist",
  "Head of Pre School in London UK",
  "Customer Service Consultant",
  "Vessel Manager x 2",
  "college management system",
  "social media moderator",
];
List<String> gradesList = ["--Select--", 'Excellent', 'Very Good', 'Good'];
List<String> nationalityList = [
  "--Select--",
  'Egyptian',
  'American',
  'Canadian',
  'Russian',
  'Australian',
  'Bahamaian',
  'Brazilian',
  'French',
  'Greek'
];
List<String> experienceLevel = ["--Select--", "0-1 years", "2-4 years", "5-10 years", "10+ years"];
List<String> jopType = ["--Select--", "Full-Time", 'Remote', "Part-Time", "Contract"];
List<String> genderList = ["--Select--", "Male", "Female"];
List<String> uniList = [
  "--Select--",
  "Cairo University",
  "Mansoura University",
  "Ain Shams University",
  "Alexandria University",
  "Kafrelsheikh University",
  "AAST",
  "Al Azhar University",
  "MTI",
  "MSA",
  "Modern Academy"
];
List<String> educationLevelsList = ["--Select--", "Masters", "phd", 'Bachelors'];
List<String> facultiesList = [
  "--Select--",
  "computer science",
  "Engineering",
  'bussiness',
  'Medicine',
  'Law',
  'Art',
  'Mass Communication'
];
List<String> positionsList = [
  "--Select--",
  "Team leader",
  "Manager",
  'Administrative assistant',
  'Business analyst',
  'Sales representative',
  'Marketing manager',
  'Product manager',
  'Software engineer',
  'Project Manager',
  'Marketing Coordinator',
  'Supervisor',
  'Quality Control',
  'Accounting Staff',
];

List<String> skillsList = [
  'Java',
  'Python',
  'C++',
  'JavaScript',
  'Ruby',
  'HTML',
  'CSS',
  'React',
  'Angular',
  'Vue',
  'Android',
  'iOS',
  'Node.js',
  'Django',
  'Flask',
  'SQL',
  'MongoDB',
  'Git'
];