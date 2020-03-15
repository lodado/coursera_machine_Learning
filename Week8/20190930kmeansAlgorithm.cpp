

#include<iostream>
#include<vector>
#include <stdlib.h>
#include <ctime>

using namespace std;
/*

	3���� ����

	 ��ǥ�� 3��

	 ���� n�� �ִ� (xyz)

	pointer�� ���� file�� ����Ǿ��ִ�.

	k���� �׷�ȭ Ki�� �߽����� Kj�� �߽����� �����

*/

class filE {

public:

	double x, y, z;

	bool checked;

	filE();

	filE(double newx, double newy, double newz);

	double getDistance(filE& b);

};

filE::filE() {
	checked = false;
}

filE::filE(double newx, double newy, double newz)
{
	x = newx;

	y = newy;

	z = newz;

	checked = false;

}

double filE::getDistance(filE& b)

{

	double num = (x - b.x)*(x - b.x) + (y - b.y)*(y - b.y) + (z - b.z)*(z - b.z);

	return sqrt(num);

}

#define k 5
int main()
{
	int numofData = 15;


	srand((unsigned)time(NULL));
	

	filE* F = new filE[k];
	filE* center = new filE[k];
	double group[1000] = { 0, };
	

	vector<pair<filE,int> > vec[k];
	vector<filE> data;
	vector<double> distance[1000];

	//randomly picked
	for (int i = 0; i < numofData; i++)
	{
		filE newfile((double)(rand() % 100), (double)(rand() % 100), (double)(rand() % 100));

		printf("%d�� �� = (%.0lf,%.0lf,%.0lf)\n", i + 1, newfile.x, newfile.y, newfile.z);
		data.push_back(newfile);
	}

	//������ ������ ����
	for (int i = 0; i < k; i++)
	{
		F[i] = data[i];
		center[i].x = data[i].x;
		center[i].y = data[i].y;
		center[i].z = data[i].z;

		distance[i].resize(numofData);
	}

	bool whenisitend = true;

	//������ ���� ���� �Ȱ����� end
	while (whenisitend)
	{
		//�ʱ�ȭ
		for (int i = 0; i < k; i++)
		{
			center[i].x = 0;
			center[i].y = 0;
			center[i].z = 0;

			group[i] = 0;
		}
		//�Ÿ�
		for (int i = 0; i < data.size(); i++)
		{
			for (int j = 0; j < k; j++)
			{
				double dist = sqrt(F[j].getDistance(data[i]));

				distance[j][i] = dist;
			}
		}

		for (int i = 0; i < data.size(); i++)
		{
			double min = distance[0][i];
			int min_j = 0;

			for (int j = 1; j < k; j++)
			{
				if (min > distance[j][i])
				{
					min = distance[j][i];
					min_j = j;
				}
			}

			center[min_j].x += data[i].x;
			center[min_j].y += data[i].y;
			center[min_j].z += data[i].z;

			group[min_j]++;
		}

		int same_count = 0;

		for (int i = 0; i < k; i++)
		{
			if (group[i] != 0)
			{
				if ((center[i].x / group[i] == F[i].x) && (center[i].y / group[i] == F[i].y) && (center[i].z / group[i] == F[i].z)) same_count++;

				F[i].x = center[i].x / group[i];
				F[i].y = center[i].y / group[i];
				F[i].z = center[i].z / group[i];
			}

			if (same_count == k) whenisitend = false;

			//printf("(%lf,%lf,%lf) ", F[i].x, F[i].y, F[i].z);
		}cout << endl;
	}

	for (int i = 0; i < data.size(); i++)
	{
		double min = distance[0][i];
		int last = 0;
		for (int j = 0; j < k; j++)
		{
			if (min > distance[j][i])
			{
				min = distance[j][i];
				last = j;
			}
		}
		printf("��ǥ�� (%.0lf,%.0lf,%.0lf)�� %d�� ���� ", data[i].x, data[i].y, data[i].z, i + 1);
		vec[last].push_back(make_pair(data[i],i+1));
		cout << last << "�� ���� \n";
	}cout << endl;

	

	for (int i = 0; i < k; i++)
	{
		cout << "=================================\n";
		cout << i <<"�� ������ \n";

		for(int j=0; j<vec[i].size(); j++) printf("%d�� �� (%.0lf,%.0lf,%.0lf)�� ������ �ִ�.\n",vec[i][j].second, vec[i][j].first.x,vec[i][j].first.y,vec[i][j].first.z);
	}cout <<endl;

	system("PAUSE");
	return 0;

}


