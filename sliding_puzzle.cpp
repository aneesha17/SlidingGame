#include <bits/stdc++.h>
using namespace std;

string mat2str(vector<vector<int>> &board) {
	string ans = "";
	for(auto vect : board)
		for(int element : vect)
			ans += to_string(element);
	return ans;
}

vector<vector<int>> str2mat(string &board_str, int r, int c) {
	vector<vector<int>> ans(r, vector<int> (c));
	
	if(r*c != board_str.length())
		return ans;
	
	int index = 0;
	for(int i = 0; i < r; i++)
		for(int j = 0; j < c; j++)
			ans[i][j] = board_str[index++] - '0';
	return ans;
}


class Puzzle {
	char difficulty;
	int r,c,i,j;
	stack<pair<int,int>>st;

	vector<vector<int>> b;
	unordered_map<int, vector<int>> moves;
	string s, target;

	unordered_map<string, int> m;
	queue<pair<string, int>> q;
	vector<vector<int>>  dir = {{0, -1}, {0, 1}, {-1, 0}, {1, 0}};


public:

	Puzzle(vector<vector<int>>& b) {
		this->b = b;
		this->moves = {{0,{1,3}},{1,{0,2,4}},{2,{1,5}},{3,{0,4,6}},{4,{3,5,1,7}},{5,{4,2,8}},{6,{3,7}},{7,{4,6,8}},{8,{5,7}}};
		this->s = to_string(b[0][0]) + to_string(b[0][1]) + to_string(b[0][2]) + to_string(b[1][0]) + to_string(b[1][1]) + to_string(b[1][2]) + to_string(b[2][0]) + to_string(b[2][1]) + to_string(b[2][2]);
		this->target = "123456780";
		int p=s.find('0');
		this->i=(p+1)/3;
		this->j=p%3+1;

	}

	int solve() {
		this->s = to_string(b[0][0]) + to_string(b[0][1]) + to_string(b[0][2]) + to_string(b[1][0]) + to_string(b[1][1]) + to_string(b[1][2]) + to_string(b[2][0]) + to_string(b[2][1]) + to_string(b[2][2]);

		m.insert({{s, 0}});
		q.push({s, s.find('0')});

		for (;!q.empty() && q.front().first != target;q.pop()) {
	    for (auto new_zero : moves[q.front().second]) {
	      auto str = q.front().first;
	      int cur_zero = q.front().second;

	      swap(str[cur_zero], str[new_zero]);

	      if (m.insert({str, m[q.front().first] + 1}).second) q.push({ str, new_zero });
	    }   
	  }

	  m[s] = 0;
	  return q.empty() ? -1 : m[q.front().first];
	}
	 
    
    
	string hint(vector<vector<int>> board) {
		unordered_map<string, int> memo;
        int m = board.size(), n = board[0].size();
        int i=this->i-1,j=this->j-1;
        string hash = "123456780";
        int  mini = INT_MAX;
        list<pair<pair<int, int>, pair<vector<vector<int>>,string>>> ver;

        string curr = mat2str(board);
        ver.push_back(make_pair(make_pair(i, j), make_pair(board,curr)));
        
    	memo[curr] = 0;
    	int flag=0;
    	string ans=this->s;
        while (!ver.empty()) {
            i = ver.front().first.first, j = ver.front().first.second;
            board = ver.front().second.first;
            string ls=ver.front().second.second;
            ver.pop_front();
            
            string val = mat2str(board);
            if (val==hash)   
            {
            	if(mini>memo[val])
            	{
            		ans=ls;
                }
                mini = min(mini, memo[val]);

                continue;
            }
            for (int d = 0; d < dir.size(); d++) {
                int x = i + dir[d][0], y = j + dir[d][1];
                if (x >= 0 && x < m && y >= 0 && y < n) {
                    vector<vector<int>> b = board;
                    swap(b[i][j], b[x][y]);                    
                    string v = mat2str(b);
                	if (!memo.count(v) || memo[v] > memo[val] + 1) {
                        memo[v] = memo[val] + 1;
                        if(flag==0)
                        {
                        ver.push_back(make_pair(make_pair(x, y), make_pair(b,v)));
                        }
                        else
                        ver.push_back(make_pair(make_pair(x, y), make_pair(b,ls)));
                    }
                }
            }          
            flag++; 
        }
        return ans;
    }
	 
	void move(vector<vector<int>>&board,string v)
	{
		int p=v.find('0');
		int val=board[p/3][p%3];
		if(i<3&&board[i][j-1]==val)
		{
			board[i][j-1]=0;
			board[i-1][j-1]=val;
			st.push({1,0});
			i=i+1;
		}
		else if(j<3&&board[i-1][j]==val)
		{
			board[i-1][j]=0;
			board[i-1][j-1]=val;
			st.push({0,1});
			j=j+1;
		}
		else if(i>1&&board[i-2][j-1]==val)
		{
			board[i-2][j-1]=0;
			board[i-1][j-1]=val;
			st.push({-1,0});
			i=i-1;
		}
		else if(j>1&&board[i-1][j-2]==val)
		{
			board[i-1][j-2]=0;
			board[i-1][j-1]=val;
			st.push({0,-1});
			j=j-1;
		}
		else
		{
			cout<<"Invalid move";
		}
		this->s = to_string(b[0][0]) + to_string(b[0][1]) + to_string(b[0][2]) + to_string(b[1][0]) + to_string(b[1][1]) + to_string(b[1][2]) + to_string(b[2][0]) + to_string(b[2][1]) + to_string(b[2][2]);

	}
	void last_move(vector<vector<int>>&board)
	{
		if(st.top().first==1)
		{
			board[i-1][j-1]=board[i-2][j-1];
			board[i-2][j-1]=0;
			i--;
		}
		else if(st.top().first==-1)	
		{
			board[i-1][j-1]=board[i][j-1];
			board[i][j-1]=0;
			i++;
		}
		else if(st.top().second==1)
		{
			board[i-1][j-1]=board[i-1][j-2];
			board[i-1][j-2]=0;
			j--;
		}
		else if(st.top().second==-1)	
		{
			board[i-1][j-1]=board[i-1][j];
			board[i-1][j]=0;
			j++;
		}
		st.pop();
		this->s = to_string(b[0][0]) + to_string(b[0][1]) + to_string(b[0][2]) + to_string(b[1][0]) + to_string(b[1][1]) + to_string(b[1][2]) + to_string(b[2][0]) + to_string(b[2][1]) + to_string(b[2][2]);

	}

};


int main() {
	vector<vector<int>> board = {{2,3,0},{1,4,6},{7,5,8}};
	Puzzle *puzzle = new Puzzle(board);
	while(mat2str(board)!="123456780")
	{
		puzzle->move(board,puzzle->hint(board));
	}

	int numMoves = puzzle->solve();
	cout << numMoves << endl;
	for(auto vect : board) {
		for(auto itr : vect)
			cout << itr << " ";
		cout << endl;
	}

	// string sorted_str = "012345678";
	// sort(sorted_str.begin(),sorted_str.end(), greater<int>());
	// do {
	// 	board = str2mat(sorted_str,3,3);
	// 	puzzle = new Puzzle(board);
	// 	int numMoves = puzzle->solve();
	// 	cout << endl;
	// 	cout << numMoves << endl;
	// 	for(auto vect : board) {
	// 		for(auto itr : vect)
	// 			cout << itr << " ";
	// 		cout << endl;
	// 	}
	// } while(prev_permutation(sorted_str.begin(),sorted_str.end()));
	return 0;
}