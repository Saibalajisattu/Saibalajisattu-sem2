package weka;

import weka.core.Instances;
import weka.core.converters.ConverterUtils.DataSource;
import weka.filters.Filter;
import weka.filters.unsupervised.attribute.StringToWordVector;
import weka.filters.unsupervised.attribute.NominalToBinary;
import weka.classifiers.trees.J48;
import weka.classifiers.Evaluation;

import java.util.Random;

public class EventClassifierModelOnly {
    public static void main(String[] args) {
        try {
            // Load ARFF file
            DataSource source = new DataSource("data.arff");
            Instances data = source.getDataSet();

            // Set class attribute (e.g., eventType as the class index)
            data.setClassIndex(0);

            // Convert categorical attributes to binary
            NominalToBinary nominalFilter = new NominalToBinary();
            nominalFilter.setInputFormat(data);
            data = Filter.useFilter(data, nominalFilter);

            // Convert text attributes to numeric word vectors
            StringToWordVector textFilter = new StringToWordVector();
            textFilter.setInputFormat(data);
            data = Filter.useFilter(data, textFilter);

            // Train J48 Decision Tree model
            J48 treeModel = new J48();
            treeModel.buildClassifier(data);

            // Evaluate the model using 10-fold cross-validation
            Evaluation eval = new Evaluation(data);
            eval.crossValidateModel(treeModel, data, 10, new Random(1));

            // Output evaluation summary
            System.out.println("=== J48 Decision Tree Model Evaluation ===");
            System.out.println(eval.toSummaryString());
            System.out.println("Confusion Matrix:");
            System.out.println(eval.toMatrixString());

        } catch (Exception e) {
            e.printStackTrace();
        }
    }
}
