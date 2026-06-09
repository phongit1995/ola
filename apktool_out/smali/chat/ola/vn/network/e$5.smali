.class Lchat/ola/vn/network/e$5;
.super Ljava/lang/Object;

# interfaces
.implements Ljava/lang/Runnable;


# annotations
.annotation system Ldalvik/annotation/EnclosingMethod;
    value = Lchat/ola/vn/network/e;->b(Ljava/lang/String;Ljava/util/List;S)V
.end annotation

.annotation system Ldalvik/annotation/InnerClass;
    accessFlags = 0x0
    name = null
.end annotation


# instance fields
.field final synthetic a:Ljava/lang/String;

.field final synthetic b:Ljava/util/List;

.field final synthetic c:S

.field final synthetic d:Lchat/ola/vn/network/e;


# direct methods
.method constructor <init>(Lchat/ola/vn/network/e;Ljava/lang/String;Ljava/util/List;S)V
    .locals 0

    iput-object p1, p0, Lchat/ola/vn/network/e$5;->d:Lchat/ola/vn/network/e;

    iput-object p2, p0, Lchat/ola/vn/network/e$5;->a:Ljava/lang/String;

    iput-object p3, p0, Lchat/ola/vn/network/e$5;->b:Ljava/util/List;

    iput-short p4, p0, Lchat/ola/vn/network/e$5;->c:S

    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    return-void
.end method

.method private a(Ljava/util/List;)V
    .locals 4
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "(",
            "Ljava/util/List<",
            "Lchat/ola/vn/entity/aa;",
            ">;)V"
        }
    .end annotation

    :try_start_0
    invoke-interface {p1}, Ljava/util/List;->iterator()Ljava/util/Iterator;

    move-result-object p1

    :cond_0
    :goto_0
    invoke-interface {p1}, Ljava/util/Iterator;->hasNext()Z

    move-result v0

    if-eqz v0, :cond_2

    invoke-interface {p1}, Ljava/util/Iterator;->next()Ljava/lang/Object;

    move-result-object v0

    check-cast v0, Lchat/ola/vn/entity/aa;
    :try_end_0
    .catch Ljava/lang/Throwable; {:try_start_0 .. :try_end_0} :catch_3

    :try_start_1
    iget-object v1, v0, Lchat/ola/vn/entity/aa;->a:Ljava/lang/String;

    const-string v2, "rsshistory"

    invoke-static {v1, v2}, Lchat/ola/vn/util/m;->b(Ljava/lang/String;Ljava/lang/String;)Z

    move-result v1
    :try_end_1
    .catch Ljava/lang/Throwable; {:try_start_1 .. :try_end_1} :catch_2

    const/4 v2, 0x1

    if-eqz v1, :cond_1

    :try_start_2
    iget-object v0, v0, Lchat/ola/vn/entity/aa;->b:[B

    invoke-static {v0}, Lchat/ola/vn/h/b;->b([B)Ljava/util/List;

    move-result-object v0

    sget-object v1, Lchat/ola/vn/h;->s:Lchat/ola/vn/r/b;

    invoke-virtual {v1, v0}, Lchat/ola/vn/r/b;->b(Ljava/util/List;)V
    :try_end_2
    .catch Ljava/lang/Throwable; {:try_start_2 .. :try_end_2} :catch_0

    :catch_0
    :try_start_3
    sget-object v0, Lchat/ola/vn/h;->s:Lchat/ola/vn/r/b;

    invoke-virtual {v0, v2}, Lchat/ola/vn/r/b;->b(Z)V

    sget-object v0, Lchat/ola/vn/h;->s:Lchat/ola/vn/r/b;

    :goto_1
    invoke-virtual {v0}, Lchat/ola/vn/r/b;->g()V

    goto :goto_0

    :cond_1
    iget-object v1, v0, Lchat/ola/vn/entity/aa;->a:Ljava/lang/String;

    const-string v3, "rssbookmark"

    invoke-static {v1, v3}, Lchat/ola/vn/util/m;->b(Ljava/lang/String;Ljava/lang/String;)Z

    move-result v1
    :try_end_3
    .catch Ljava/lang/Throwable; {:try_start_3 .. :try_end_3} :catch_2

    if-eqz v1, :cond_0

    :try_start_4
    iget-object v0, v0, Lchat/ola/vn/entity/aa;->b:[B

    invoke-static {v0}, Lchat/ola/vn/h/b;->b([B)Ljava/util/List;

    move-result-object v0

    sget-object v1, Lchat/ola/vn/h;->s:Lchat/ola/vn/r/b;

    invoke-virtual {v1, v0}, Lchat/ola/vn/r/b;->a(Ljava/util/List;)V
    :try_end_4
    .catch Ljava/lang/Throwable; {:try_start_4 .. :try_end_4} :catch_1

    :catch_1
    :try_start_5
    sget-object v0, Lchat/ola/vn/h;->s:Lchat/ola/vn/r/b;

    invoke-virtual {v0, v2}, Lchat/ola/vn/r/b;->a(Z)V

    sget-object v0, Lchat/ola/vn/h;->s:Lchat/ola/vn/r/b;
    :try_end_5
    .catch Ljava/lang/Throwable; {:try_start_5 .. :try_end_5} :catch_2

    goto :goto_1

    :catch_2
    move-exception v0

    :try_start_6
    invoke-virtual {v0}, Ljava/lang/Throwable;->printStackTrace()V
    :try_end_6
    .catch Ljava/lang/Throwable; {:try_start_6 .. :try_end_6} :catch_3

    goto :goto_0

    :catch_3
    :cond_2
    return-void
.end method

.method private b(Ljava/util/List;)V
    .locals 5
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "(",
            "Ljava/util/List<",
            "Lchat/ola/vn/entity/aa;",
            ">;)V"
        }
    .end annotation

    :try_start_0
    invoke-interface {p1}, Ljava/util/List;->iterator()Ljava/util/Iterator;

    move-result-object p1

    :catch_0
    :cond_0
    :goto_0
    invoke-interface {p1}, Ljava/util/Iterator;->hasNext()Z

    move-result v0

    if-eqz v0, :cond_7

    invoke-interface {p1}, Ljava/util/Iterator;->next()Ljava/lang/Object;

    move-result-object v0

    check-cast v0, Lchat/ola/vn/entity/aa;
    :try_end_0
    .catch Ljava/lang/Throwable; {:try_start_0 .. :try_end_0} :catch_7

    :try_start_1
    iget-object v1, v0, Lchat/ola/vn/entity/aa;->a:Ljava/lang/String;

    const-string v2, "usersettings"

    invoke-static {v1, v2}, Lchat/ola/vn/util/m;->b(Ljava/lang/String;Ljava/lang/String;)Z

    move-result v1

    if-eqz v1, :cond_0

    iget-object v0, v0, Lchat/ola/vn/entity/aa;->b:[B

    invoke-static {v0}, Lchat/ola/vn/util/o;->b([B)Lchat/ola/vn/w/s;

    move-result-object v0
    :try_end_1
    .catch Ljava/lang/Throwable; {:try_start_1 .. :try_end_1} :catch_0

    const/16 v1, 0x6b

    const/4 v2, 0x1

    :try_start_2
    invoke-virtual {v0, v1}, Lchat/ola/vn/w/s;->b(S)Ljava/lang/String;

    move-result-object v1

    sput-boolean v2, Lchat/ola/vn/c/x;->u:Z

    invoke-static {v1}, Lchat/ola/vn/util/m;->a(Ljava/lang/String;)Z

    move-result v3

    if-nez v3, :cond_1

    invoke-static {v1}, Ljava/lang/Boolean;->parseBoolean(Ljava/lang/String;)Z

    move-result v1

    sput-boolean v1, Lchat/ola/vn/c/x;->u:Z
    :try_end_2
    .catch Ljava/lang/Throwable; {:try_start_2 .. :try_end_2} :catch_1

    :catch_1
    :cond_1
    const/16 v1, 0x56

    const/4 v3, 0x0

    :try_start_3
    invoke-virtual {v0, v1}, Lchat/ola/vn/w/s;->b(S)Ljava/lang/String;

    move-result-object v1

    sput-byte v3, Lchat/ola/vn/c/x;->l:B

    invoke-static {v1}, Lchat/ola/vn/util/m;->a(Ljava/lang/String;)Z

    move-result v4

    if-nez v4, :cond_2

    invoke-static {v1}, Ljava/lang/Byte;->parseByte(Ljava/lang/String;)B

    move-result v1

    sput-byte v1, Lchat/ola/vn/c/x;->l:B
    :try_end_3
    .catch Ljava/lang/Throwable; {:try_start_3 .. :try_end_3} :catch_2

    :catch_2
    :cond_2
    const/16 v1, 0x68

    :try_start_4
    invoke-virtual {v0, v1}, Lchat/ola/vn/w/s;->b(S)Ljava/lang/String;

    move-result-object v1

    sput-boolean v2, Lchat/ola/vn/c/x;->t:Z

    invoke-static {v1}, Lchat/ola/vn/util/m;->a(Ljava/lang/String;)Z

    move-result v4

    if-nez v4, :cond_3

    invoke-static {v1}, Ljava/lang/Boolean;->parseBoolean(Ljava/lang/String;)Z

    move-result v1

    sput-boolean v1, Lchat/ola/vn/c/x;->t:Z
    :try_end_4
    .catch Ljava/lang/Throwable; {:try_start_4 .. :try_end_4} :catch_3

    :catch_3
    :cond_3
    const/16 v1, 0x69

    :try_start_5
    invoke-virtual {v0, v1}, Lchat/ola/vn/w/s;->b(S)Ljava/lang/String;

    move-result-object v1

    invoke-static {v3}, Ljava/lang/Boolean;->valueOf(Z)Ljava/lang/Boolean;

    move-result-object v4

    sput-object v4, Lchat/ola/vn/c/x;->b:Ljava/lang/Boolean;

    invoke-static {v1}, Lchat/ola/vn/util/m;->a(Ljava/lang/String;)Z

    move-result v4

    if-nez v4, :cond_4

    invoke-static {v1}, Ljava/lang/Boolean;->parseBoolean(Ljava/lang/String;)Z

    move-result v1

    invoke-static {v1}, Ljava/lang/Boolean;->valueOf(Z)Ljava/lang/Boolean;

    move-result-object v1

    sput-object v1, Lchat/ola/vn/c/x;->b:Ljava/lang/Boolean;
    :try_end_5
    .catch Ljava/lang/Throwable; {:try_start_5 .. :try_end_5} :catch_4

    :catch_4
    :cond_4
    const/16 v1, 0x5b

    :try_start_6
    invoke-virtual {v0, v1}, Lchat/ola/vn/w/s;->b(S)Ljava/lang/String;

    move-result-object v1

    sput-boolean v2, Lchat/ola/vn/c/x;->r:Z

    invoke-static {v1}, Lchat/ola/vn/util/m;->a(Ljava/lang/String;)Z

    move-result v2

    if-nez v2, :cond_5

    invoke-static {v1}, Ljava/lang/Boolean;->parseBoolean(Ljava/lang/String;)Z

    move-result v1

    sput-boolean v1, Lchat/ola/vn/c/x;->r:Z
    :try_end_6
    .catch Ljava/lang/Throwable; {:try_start_6 .. :try_end_6} :catch_5

    :catch_5
    :cond_5
    const/16 v1, 0x5f

    :try_start_7
    invoke-virtual {v0, v1}, Lchat/ola/vn/w/s;->b(S)Ljava/lang/String;

    move-result-object v1

    sput-boolean v3, Lchat/ola/vn/c/x;->s:Z

    invoke-static {v1}, Lchat/ola/vn/util/m;->a(Ljava/lang/String;)Z

    move-result v2

    if-nez v2, :cond_6

    invoke-static {v1}, Ljava/lang/Boolean;->parseBoolean(Ljava/lang/String;)Z

    move-result v1

    sput-boolean v1, Lchat/ola/vn/c/x;->s:Z
    :try_end_7
    .catch Ljava/lang/Throwable; {:try_start_7 .. :try_end_7} :catch_6

    :catch_6
    :cond_6
    const/16 v1, 0x65

    :try_start_8
    invoke-virtual {v0, v1}, Lchat/ola/vn/w/s;->b(S)Ljava/lang/String;

    move-result-object v0

    sput-byte v3, Lchat/ola/vn/c/x;->p:B

    invoke-static {v0}, Lchat/ola/vn/util/m;->a(Ljava/lang/String;)Z

    move-result v1

    if-nez v1, :cond_0

    invoke-static {v0}, Ljava/lang/Byte;->parseByte(Ljava/lang/String;)B

    move-result v0

    sput-byte v0, Lchat/ola/vn/c/x;->p:B
    :try_end_8
    .catch Ljava/lang/Throwable; {:try_start_8 .. :try_end_8} :catch_0

    goto/16 :goto_0

    :catch_7
    :cond_7
    return-void
.end method

.method private c(Ljava/util/List;)V
    .locals 7
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "(",
            "Ljava/util/List<",
            "Lchat/ola/vn/entity/aa;",
            ">;)V"
        }
    .end annotation

    :try_start_0
    invoke-interface {p1}, Ljava/util/List;->iterator()Ljava/util/Iterator;

    move-result-object p1

    :cond_0
    :goto_0
    invoke-interface {p1}, Ljava/util/Iterator;->hasNext()Z

    move-result v0

    if-eqz v0, :cond_6

    invoke-interface {p1}, Ljava/util/Iterator;->next()Ljava/lang/Object;

    move-result-object v0

    check-cast v0, Lchat/ola/vn/entity/aa;
    :try_end_0
    .catch Ljava/lang/Throwable; {:try_start_0 .. :try_end_0} :catch_1

    :try_start_1
    iget-object v1, v0, Lchat/ola/vn/entity/aa;->a:Ljava/lang/String;

    const-string v2, "mehistory"

    invoke-static {v1, v2}, Lchat/ola/vn/util/m;->b(Ljava/lang/String;Ljava/lang/String;)Z

    move-result v1

    if-eqz v1, :cond_0

    iget-object v0, v0, Lchat/ola/vn/entity/aa;->b:[B

    invoke-static {v0}, Lchat/ola/vn/h/b;->a([B)Ljava/util/List;

    move-result-object v0

    if-eqz v0, :cond_5

    invoke-interface {v0}, Ljava/util/List;->size()I

    move-result v1

    if-lez v1, :cond_5

    new-instance v1, Ljava/util/ArrayList;

    invoke-direct {v1}, Ljava/util/ArrayList;-><init>()V

    invoke-interface {v0}, Ljava/util/List;->iterator()Ljava/util/Iterator;

    move-result-object v0

    :cond_1
    :goto_1
    invoke-interface {v0}, Ljava/util/Iterator;->hasNext()Z

    move-result v2

    if-eqz v2, :cond_4

    invoke-interface {v0}, Ljava/util/Iterator;->next()Ljava/lang/Object;

    move-result-object v2

    check-cast v2, Lchat/ola/vn/entry/g;

    invoke-virtual {v2}, Lchat/ola/vn/entry/g;->a()Ljava/lang/String;

    move-result-object v3

    invoke-static {v3}, Lchat/ola/vn/util/m;->a(Ljava/lang/String;)Z

    move-result v4

    if-nez v4, :cond_1

    new-instance v4, Lchat/ola/vn/entity/x;

    invoke-direct {v4}, Lchat/ola/vn/entity/x;-><init>()V

    const-string v5, "#"

    invoke-virtual {v3, v5}, Ljava/lang/String;->startsWith(Ljava/lang/String;)Z

    move-result v5

    if-eqz v5, :cond_2

    iput-object v3, v4, Lchat/ola/vn/entity/x;->c:Ljava/lang/String;

    const/4 v3, 0x1

    iput-byte v3, v4, Lchat/ola/vn/entity/x;->a:B

    goto :goto_2

    :cond_2
    new-instance v5, Ljava/lang/StringBuilder;

    invoke-direct {v5}, Ljava/lang/StringBuilder;-><init>()V

    const-string v6, "@"

    invoke-virtual {v5, v6}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    invoke-virtual {v5, v3}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    invoke-virtual {v5}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v3

    iput-object v3, v4, Lchat/ola/vn/entity/x;->c:Ljava/lang/String;

    const/4 v3, 0x0

    iput-byte v3, v4, Lchat/ola/vn/entity/x;->a:B

    :goto_2
    if-nez v1, :cond_3

    new-instance v1, Ljava/util/ArrayList;

    invoke-direct {v1}, Ljava/util/ArrayList;-><init>()V

    :cond_3
    invoke-interface {v1, v2}, Ljava/util/List;->add(Ljava/lang/Object;)Z

    invoke-static {v4}, Lchat/ola/vn/g;->a(Lchat/ola/vn/entity/x;)V

    goto :goto_1

    :cond_4
    if-eqz v1, :cond_0

    sget-object v0, Lchat/ola/vn/h;->w:Lchat/ola/vn/r/a;

    invoke-interface {v0, v1}, Lchat/ola/vn/r/a;->a(Ljava/util/List;)V

    goto/16 :goto_0

    :cond_5
    sget-object v0, Lchat/ola/vn/h;->w:Lchat/ola/vn/r/a;

    const/4 v1, 0x0

    invoke-interface {v0, v1}, Lchat/ola/vn/r/a;->a(Ljava/util/List;)V
    :try_end_1
    .catch Ljava/lang/Throwable; {:try_start_1 .. :try_end_1} :catch_0

    goto/16 :goto_0

    :catch_0
    move-exception v0

    :try_start_2
    invoke-virtual {v0}, Ljava/lang/Throwable;->printStackTrace()V
    :try_end_2
    .catch Ljava/lang/Throwable; {:try_start_2 .. :try_end_2} :catch_1

    goto/16 :goto_0

    :catch_1
    :cond_6
    return-void
.end method


# virtual methods
.method public run()V
    .locals 5

    const/4 v0, 0x1

    :try_start_0
    iget-object v1, p0, Lchat/ola/vn/network/e$5;->a:Ljava/lang/String;

    const-string v2, "bmk"

    invoke-static {v1, v2}, Lchat/ola/vn/util/m;->b(Ljava/lang/String;Ljava/lang/String;)Z

    move-result v1

    if-eqz v1, :cond_0

    iget-object v1, p0, Lchat/ola/vn/network/e$5;->b:Ljava/util/List;

    invoke-direct {p0, v1}, Lchat/ola/vn/network/e$5;->c(Ljava/util/List;)V

    goto :goto_0

    :cond_0
    iget-object v1, p0, Lchat/ola/vn/network/e$5;->a:Ljava/lang/String;

    const-string v2, "set"

    invoke-static {v1, v2}, Lchat/ola/vn/util/m;->b(Ljava/lang/String;Ljava/lang/String;)Z

    move-result v1

    if-eqz v1, :cond_1

    iget-object v1, p0, Lchat/ola/vn/network/e$5;->b:Ljava/util/List;

    invoke-direct {p0, v1}, Lchat/ola/vn/network/e$5;->b(Ljava/util/List;)V

    goto :goto_0

    :cond_1
    iget-object v1, p0, Lchat/ola/vn/network/e$5;->a:Ljava/lang/String;

    const-string v2, "rss"

    invoke-static {v1, v2}, Lchat/ola/vn/util/m;->b(Ljava/lang/String;Ljava/lang/String;)Z

    move-result v1

    if-eqz v1, :cond_2

    iget-object v1, p0, Lchat/ola/vn/network/e$5;->b:Ljava/util/List;

    invoke-direct {p0, v1}, Lchat/ola/vn/network/e$5;->a(Ljava/util/List;)V
    :try_end_0
    .catch Ljava/lang/Throwable; {:try_start_0 .. :try_end_0} :catch_0
    .catchall {:try_start_0 .. :try_end_0} :catchall_0

    :cond_2
    :goto_0
    :try_start_1
    sget-object v1, Lchat/ola/vn/h;->u:Lchat/ola/vn/r/a/e;

    :goto_1
    iput-boolean v0, v1, Lchat/ola/vn/r/a/e;->g:Z

    sput-boolean v0, Lchat/ola/vn/g;->c:Z

    goto :goto_2

    :catchall_0
    move-exception v1

    sget-object v2, Lchat/ola/vn/h;->u:Lchat/ola/vn/r/a/e;

    iput-boolean v0, v2, Lchat/ola/vn/r/a/e;->g:Z

    sput-boolean v0, Lchat/ola/vn/g;->c:Z

    throw v1

    :catch_0
    sget-object v1, Lchat/ola/vn/h;->u:Lchat/ola/vn/r/a/e;

    goto :goto_1

    :goto_2
    iget-short v1, p0, Lchat/ola/vn/network/e$5;->c:S

    invoke-static {v1}, Lchat/ola/vn/entry/c/f;->b(S)Lchat/ola/vn/entry/c/e;

    move-result-object v1

    if-eqz v1, :cond_4

    iget-object v2, p0, Lchat/ola/vn/network/e$5;->b:Ljava/util/List;

    if-eqz v2, :cond_3

    const/4 v2, 0x3

    new-array v2, v2, [Ljava/lang/Object;

    const/4 v3, 0x0

    iget-object v4, p0, Lchat/ola/vn/network/e$5;->a:Ljava/lang/String;

    aput-object v4, v2, v3

    iget-object v3, p0, Lchat/ola/vn/network/e$5;->b:Ljava/util/List;

    aput-object v3, v2, v0

    const/4 v0, 0x2

    iget-short v3, p0, Lchat/ola/vn/network/e$5;->c:S

    invoke-static {v3}, Ljava/lang/Short;->valueOf(S)Ljava/lang/Short;

    move-result-object v3

    aput-object v3, v2, v0

    invoke-virtual {v1, v2}, Lchat/ola/vn/entry/c/e;->a([Ljava/lang/Object;)V

    return-void

    :cond_3
    const/16 v0, 0x22

    const/16 v2, 0x50

    const/4 v3, 0x0

    invoke-virtual {v1, v0, v2, v3, v3}, Lchat/ola/vn/entry/c/e;->a(ISLjava/lang/String;[Lchat/ola/vn/entity/d;)V
    :try_end_1
    .catch Ljava/lang/Throwable; {:try_start_1 .. :try_end_1} :catch_1

    :catch_1
    :cond_4
    return-void
.end method
