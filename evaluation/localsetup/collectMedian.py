import pandas as pd
import numpy as np
# import statistics
# import time
# import sys

def main():
	# args = []
	# for arg in sys.argv[1:]:
	# 	args.append(arg)

	# name="players"
	for name in ['q1', 'q2', 'q3']:
		suffix=str(name) + '_noEXPL'
		# negName=str(name) + '_noEXPL'
		
		medianIGWithEXPL(name, suffix)
		# medianNeg(negName)


def medianIGWithEXPL(name, suffix):

	allMed=pd.DataFrame()

	for s in ['Query', 'IGwoEXPL', 'IGwEXPL']:
		allMed[s]=''

		for db in ['1k', '10k', '100k', '1m']:
			if s == 'Query':
				fileName='./results_input_aqi/' + 'input_aqi_' + str(name) + '_' + db + '.txt'
			if s == 'IGwoEXPL':	
				fileName='./results/' + str(name) + '_' + db + '_noEXPL.txt'
			if s == 'IGwEXPL':	
				fileName='./results/' + str(name) + '_' + db + '.txt'


			f = open(fileName, 'r')
			lines = [line for line in f.readlines()]			
			f.close()

			# getMed=float(statistics.median(lines))
			getMed=np.median(np.array(lines).astype(np.float64))
			allMed.loc[db,s]=getMed

	allMed.index.name = 'provSize'
	allMed.to_csv(r'./median/'+ str(name) + '.csv', index=True, header=True)
	print(str(name)+' is generated')


# def medianNeg(negName):
# 	# print(negName)
# 	allMed=pd.DataFrame()

# 	for s in ['100', '1000', '10000']:
# 		allMed[s]=''

# 		for db in ['SSS', 'SS', 'S', 'Orig']:
# 			fileName='./results/' + str(negName) + '_' + db + '_' + s + '_10.txt'
# 			# fileName="test.txt"
# 			f = open(fileName, 'r')
# 			lines = [line for line in f.readlines()]			
# 			f.close()

# 			# getMed=float(statistics.median(lines))
# 			getMed=np.median(np.array(lines).astype(np.float))
# 			allMed.loc[db,s]=getMed

# 	allMed.index.name = 'provSize'
# 	allMed.to_csv(r'./median/'+ negName + '.csv', index=True, header=True)
# 	print(str(negName)+' is generated')


if __name__== "__main__":
    main()


