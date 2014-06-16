package org.deeplearning4j.autoencoder;

import org.deeplearning4j.nn.NeuralNetwork;
import org.deeplearning4j.nn.gradient.NeuralNetworkGradient;
import org.deeplearning4j.optimize.NeuralNetworkOptimizer;
import org.jblas.DoubleMatrix;

/**
 *   Auto Encoder Optimizer
 *
 * @author Adam Gibson
 */
public class AutoEncoderOptimizer extends NeuralNetworkOptimizer {
    public AutoEncoderOptimizer(NeuralNetwork network, double lr, Object[] trainingParams, NeuralNetwork.OptimizationAlgorithm optimizationAlgorithm, NeuralNetwork.LossFunction lossFunction) {
        super(network, lr, trainingParams, optimizationAlgorithm, lossFunction);
    }



}
