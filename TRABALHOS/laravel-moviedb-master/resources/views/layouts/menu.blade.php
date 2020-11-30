<li class="{{ Request::is('*relatorio-1*') ? 'active' : '' }}">
    <a href="relatorio-1" >Filmes por gênero</a>
</li>
<li class="{{ Request::is('*relatorio-2*') ? 'active' : '' }}">
    <a href="relatorio-2" >Filmes por ano</a>
</li>
@if(Auth::user()->hasRole('premium'))
    <li class="{{ Request::is('*relatorio-3*') ? 'active' : '' }}">
        <a href="relatorio-3" >Trending filmes por gênero</a>
    </li>
    <li class="{{ Request::is('*relatorio-4*') ? 'active' : '' }}">
        <a href="relatorio-4" >Filmes por produtora</a>
    </li>
    <li class="{{ Request::is('*relatorio-5*') ? 'active' : '' }}">
        <a href="relatorio-5" >Filmes por pessoa</a>
    </li>
@endif
