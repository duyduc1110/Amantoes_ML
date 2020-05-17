import torch
import torch.nn as nn
import torch.nn.functional as F


class Recommendation(nn.Module):
    def __init__(self, nums=1000, dim=10):
        super(Recommendation, self).__init__()
        self.embed = nn.Embedding(nums, dim)
        self.loss = nn.MSELoss()

    def forward(self, x, y=None):
        # Normalize embedding before calculate
        x = self.embed(x)
        x = F.normalize(x, dim=2)

        # Dot product vectors
        x = (x[:,0,:] * x[:,1,:])
        x = torch.sum(x, dim=1).unsqueeze(1)

        # Calculate loss
        if y is None:
            return x
        else:
            loss = self.loss(x, y)
            return loss






