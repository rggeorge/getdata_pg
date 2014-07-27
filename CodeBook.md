#CodeBook

This book describes the data that comes out of the file run_analysis.R

## Full Data

The first matrix is a full tidy data set of all mean and standard deviation observations from the test and training data sets. This is gotten by sorting the column names for 'mean' and 'std' strings, and keeping just those columns.  Test and training data sets are merged using the rbind() function.  The observations in this matrix correspond to the data described in features_info.txt. These observations fall into the categories:

- Derivative of Acceleration component
- Acceleration component
- Gravity Acceleration component
- Derivative of Gyroscope component
- Gyroscope component
- Magnitude of Acceleration
- Magnitude of Gravity Acceleration
- Magnitude of Gyroscope
- Derivative of Magnitude of Gyroscope
- FFT of Derivative of Acceleration component
- FFT of Gyroscope component
- FFT of Magnitude of Acceleration
- FFT of Derivative of Magnitude of Acceleration
- FFT of Magnitude of Gyroscope
- FFT of Derivative of Magnitude of Gyroscope

For each of these data, a mean and standard deviation is described.  For component data, an X, Y and Z direction is given. Units are in standard mobile "g" components.

## Summary data

2. The second matrix takes the mean of all of the observations from the first matrix across activity and subject.  In this matrix, each subject is a row, and each activity is a column.







