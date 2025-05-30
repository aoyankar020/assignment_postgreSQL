# Questions : What is PostgreSQL?

PostgreSQL হলো ডেটাবেসে ম্যানেজমেন্ট সিস্টেম ( DBMS) যেটি রিলেশনাল ডাটাবেস কে ম্যানেজ করে.PostgreSQL ওপেন Source .
ছোট বড় সকল প্রজেক্টেই ডেভলোপাররা PostgreSQL ব্যবহার করে আসছে। এর কমিউনিটি সাপোর্ট অনেক ভালো। আধুনিক ডাটা টাইপ ,ACID অপারেশন MVCC ,Extensible থাকায় ও প্লার্টফর্ম ডিপেন্ডেন্সি না থাকায় PostgreSQL ইউসার তুলনামূলক ভাবে অনেক বেশি।

# Questions : What is the purpose of a database schema in PostgreSQL?

schema কে আমরা infrastructure হিসেবে ভাবতে পারি।
আসলে PostgreSQL-এ স্কিমা (Schema) হলো একটি লজিক্যাল কাঠামো, যা ডাটাবেজ অবজেক্টগুলিকে গুছানো ও গ্রুপ আকারে রাখতে সাহায্য করে।
যেমনঃ পাবলিক পোস্ট গুলো অথবা কমেন্ট গুলো যদি আমি একটা পাবলিক (Schema) এর মধ্যে টেবিল আকারে রাখতে চাই তাহলে আমি পাবলিক (Schema) এর আন্ডার এ রাখতে পারি। এ ছাড়াও ভিউ (Views)
ফাংশন (Functions),সিকোয়েন্স (Sequences),টাইপ (Custom Types),
ইনডেক্স (Indexes) ইত্যাদি ও আমরা (Schema) এর মধ্যে রাখতে পারি। এতেকরে ডাটা প্রটেকশন অনেক বেড়ে যায়.

# Questions : Explain the Primary Key and Foreign Key concepts in PostgreSQL.

Primary Key হলো একটি কলাম বা কলামের সমন্বয় , যা প্রতিটি রেকর্ডকে অন্য রেকর্ড থেকে আলাদা করে। এটি ডাটাবেজের টেবিলে একটি Unique Identifier হিসেবে কাজ করে।
প্রাইমারি কী NULL হতে পারবে না। PostgreSQL এ primary key বলতেই NOT NULL and Unique. প্রাইমারি কী কনস্ট্রেইন্ট ব্যবহার করলে not null and Unique কনস্ট্রেইন্ট ব্যবহার করতে হয় না।

## Example :

CREATE TABLE courses (
course_id SERIAL PRIMARY KEY,
course_name VARCHAR(100)
);

একটি টেবিলের কী যদি অন্য টেবিল এ ব্যবহার হয় তাহলে অন্য টেবিলের জন্য ওই কী কে FOREIGN KEY বলে। ফরেন কী অন্য টেবিলের রেফারেন্স ধরে রাখার জন্য ব্যবহার করা হয়।

## Example :

CREATE TABLE enrollments (
enrollment_id SERIAL PRIMARY KEY,
student_id INT,
course_id INT,
FOREIGN KEY (course_id) REFERENCES courses(course_id)
);

# Questions : What is the difference between the VARCHAR and CHAR data types?

Varchar হচ্ছে variable-length character string ও Char হচ্ছে fixed-length character string.

## Example :

VARCHAR(5)

## Example :

CHAR(5)

# Questions : What are the LIMIT and OFFSET clauses used for?

লিমিট use করা হয় কোনো কোয়ারি থেকে নির্দিষ্ট পরিমান রেকর্ড একসেস করার জন্য .

## Example :

SELECT \* FROM students
LIMIT 5;

OFFSET use করা হয় কত গুলো রেকর্ড স্কিপ করা হবে সেটা বুঝানোর জন্য।

## Example :

SELECT \* FROM students
OFFSET 5;

আমরা লিমিট আর অফসেট Pagination করার সময় সবচেয়ে বেশি use করে থাকি .
