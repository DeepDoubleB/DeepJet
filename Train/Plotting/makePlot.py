


infile='tree_association.txt'


#from DeepJetCore.testing import makePlots_async
from DeepJetCore.evaluation import makePlots_async

makePlots_async(infile,      #input file or file list
                ['test'],    #legend names (needs to be list)
                'jet_pt',    #variable to plot
                'jet_pt>40', #cut to apply
                'green',     #line color and style (e.g. 'red,dashed')
                'test.pdf',  #output file (pdf)
                'xaxis',     #xaxisname
                'yaxis',     #yaxisname
                False)       #normalise


makePlots_async(infile,      #input file or file list
                ['central','forward'],    #legend names (needs to be list)
                'jet_pt',    #variable to plot
                ['jet_eta<1.1 && jet_eta>-1.1','jet_eta<-1.1 || jet_eta>1.1'], #cut to apply
                ['green','red'],     #line color and style (e.g. 'red,dashed')
                'test2.pdf',  #output file (pdf)
                'xaxis',     #xaxisname
                'yaxis',     #yaxisname
                True)       #normalise
