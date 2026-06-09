.class Lchat/ola/vn/network/e$46;
.super Ljava/lang/Object;

# interfaces
.implements Ljava/lang/Runnable;


# annotations
.annotation system Ldalvik/annotation/EnclosingMethod;
    value = Lchat/ola/vn/network/e;->a(Lchat/ola/vn/w/ci;S)V
.end annotation

.annotation system Ldalvik/annotation/InnerClass;
    accessFlags = 0x0
    name = null
.end annotation


# instance fields
.field final synthetic a:Lchat/ola/vn/w/ci;

.field final synthetic b:Lchat/ola/vn/network/e;


# direct methods
.method constructor <init>(Lchat/ola/vn/network/e;Lchat/ola/vn/w/ci;)V
    .locals 0

    iput-object p1, p0, Lchat/ola/vn/network/e$46;->b:Lchat/ola/vn/network/e;

    iput-object p2, p0, Lchat/ola/vn/network/e$46;->a:Lchat/ola/vn/w/ci;

    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    return-void
.end method


# virtual methods
.method public run()V
    .locals 7

    const/4 v0, 0x0

    const/4 v1, 0x1

    const/4 v2, 0x0

    :try_start_0
    iget-object v3, p0, Lchat/ola/vn/network/e$46;->b:Lchat/ola/vn/network/e;

    iget-object v3, v3, Lchat/ola/vn/network/e;->a:Lchat/ola/vn/network/OlaNetworkService;

    invoke-virtual {v3}, Lchat/ola/vn/network/OlaNetworkService;->j()I

    move-result v3

    const/4 v4, 0x6

    if-eq v3, v4, :cond_0

    return-void

    :cond_0
    iget-object v3, p0, Lchat/ola/vn/network/e$46;->b:Lchat/ola/vn/network/e;

    iget-object v3, v3, Lchat/ola/vn/network/e;->a:Lchat/ola/vn/network/OlaNetworkService;

    const/4 v4, 0x7

    invoke-virtual {v3, v4}, Lchat/ola/vn/network/OlaNetworkService;->a(I)V

    invoke-static {}, Lchat/ola/vn/OlaApplication;->a()Landroid/content/Context;

    move-result-object v3

    invoke-static {v3}, Lchat/ola/vn/util/c/b;->d(Landroid/content/Context;)V

    iget-object v3, p0, Lchat/ola/vn/network/e$46;->b:Lchat/ola/vn/network/e;

    iget-object v3, v3, Lchat/ola/vn/network/e;->a:Lchat/ola/vn/network/OlaNetworkService;

    invoke-virtual {v3}, Lchat/ola/vn/network/OlaNetworkService;->n()V

    iget-object v3, p0, Lchat/ola/vn/network/e$46;->b:Lchat/ola/vn/network/e;

    iget-object v3, v3, Lchat/ola/vn/network/e;->a:Lchat/ola/vn/network/OlaNetworkService;

    invoke-virtual {v3}, Lchat/ola/vn/network/OlaNetworkService;->o()V

    sget-object v3, Lchat/ola/vn/h;->x:Lchat/ola/vn/r/a/f;

    invoke-virtual {v3, v1}, Lchat/ola/vn/r/a/f;->a(Z)V

    invoke-static {}, Lchat/ola/vn/OlaApplication;->e()Z

    move-result v3

    if-nez v3, :cond_2

    iget-object v3, p0, Lchat/ola/vn/network/e$46;->a:Lchat/ola/vn/w/ci;

    invoke-virtual {v3}, Lchat/ola/vn/w/ci;->n()Ljava/lang/String;

    move-result-object v3

    invoke-static {v3}, Lchat/ola/vn/util/m;->a(Ljava/lang/String;)Z

    move-result v4

    if-eqz v4, :cond_1

    invoke-static {}, Lchat/ola/vn/h;->a()Ljava/lang/String;

    move-result-object v3

    goto :goto_0

    :cond_1
    new-instance v4, Ljava/lang/StringBuilder;

    invoke-direct {v4}, Ljava/lang/StringBuilder;-><init>()V

    invoke-virtual {v4, v3}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    const-string v3, " ("

    invoke-virtual {v4, v3}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    invoke-static {}, Lchat/ola/vn/h;->a()Ljava/lang/String;

    move-result-object v3

    invoke-virtual {v4, v3}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    const-string v3, ")"

    invoke-virtual {v4, v3}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    invoke-virtual {v4}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v3

    :goto_0
    const v4, 0x7f0f027c

    new-array v5, v1, [Ljava/lang/Object;

    aput-object v3, v5, v2

    invoke-static {v4, v5}, Lchat/ola/vn/OlaApplication;->a(I[Ljava/lang/Object;)Ljava/lang/String;

    move-result-object v3

    invoke-static {v3, v0}, Lchat/ola/vn/util/c/b;->a(Ljava/lang/String;Ljava/lang/String;)V

    :cond_2
    sget-object v3, Lchat/ola/vn/h;->g:Ljava/lang/String;

    if-nez v3, :cond_3

    invoke-static {}, Lchat/ola/vn/OlaApplication;->a()Landroid/content/Context;

    move-result-object v3

    invoke-static {v3}, Lchat/ola/vn/util/n;->f(Landroid/content/Context;)Ljava/lang/String;

    move-result-object v3

    sput-object v3, Lchat/ola/vn/h;->g:Ljava/lang/String;

    :cond_3
    iget-object v3, p0, Lchat/ola/vn/network/e$46;->b:Lchat/ola/vn/network/e;

    iget-object v3, v3, Lchat/ola/vn/network/e;->a:Lchat/ola/vn/network/OlaNetworkService;

    sget-object v4, Lchat/ola/vn/h;->g:Ljava/lang/String;

    sget-object v5, Lchat/ola/vn/h;->f:Ljava/lang/String;

    invoke-virtual {v3, v4, v5}, Lchat/ola/vn/network/OlaNetworkService;->d(Ljava/lang/String;Ljava/lang/String;)V

    iget-object v3, p0, Lchat/ola/vn/network/e$46;->b:Lchat/ola/vn/network/e;

    iget-object v3, v3, Lchat/ola/vn/network/e;->a:Lchat/ola/vn/network/OlaNetworkService;

    invoke-virtual {v3}, Lchat/ola/vn/network/OlaNetworkService;->r()V

    iget-object v3, p0, Lchat/ola/vn/network/e$46;->b:Lchat/ola/vn/network/e;

    iget-object v3, v3, Lchat/ola/vn/network/e;->a:Lchat/ola/vn/network/OlaNetworkService;

    invoke-virtual {v3, v2}, Lchat/ola/vn/network/OlaNetworkService;->h(S)V

    iget-object v3, p0, Lchat/ola/vn/network/e$46;->b:Lchat/ola/vn/network/e;

    iget-object v3, v3, Lchat/ola/vn/network/e;->a:Lchat/ola/vn/network/OlaNetworkService;

    iget-object v3, v3, Lchat/ola/vn/network/OlaNetworkService;->j:Ljava/util/List;

    invoke-interface {v3}, Ljava/util/List;->iterator()Ljava/util/Iterator;

    move-result-object v3

    :goto_1
    invoke-interface {v3}, Ljava/util/Iterator;->hasNext()Z

    move-result v4

    if-eqz v4, :cond_4

    invoke-interface {v3}, Ljava/util/Iterator;->next()Ljava/lang/Object;

    move-result-object v4

    check-cast v4, Lchat/ola/vn/network/f;

    invoke-interface {v4}, Lchat/ola/vn/network/f;->n()V
    :try_end_0
    .catch Ljava/lang/Throwable; {:try_start_0 .. :try_end_0} :catch_0

    goto :goto_1

    :catch_0
    :cond_4
    :try_start_1
    sget-object v3, Lchat/ola/vn/OlaApplication;->b:Lchat/ola/vn/network/OlaNetworkService;

    invoke-virtual {v3, v2}, Lchat/ola/vn/network/OlaNetworkService;->b(I)V

    sget-object v3, Lchat/ola/vn/OlaApplication;->b:Lchat/ola/vn/network/OlaNetworkService;

    invoke-virtual {v3, v2}, Lchat/ola/vn/network/OlaNetworkService;->c(I)V
    :try_end_1
    .catch Ljava/lang/Throwable; {:try_start_1 .. :try_end_1} :catch_1

    :catch_1
    :try_start_2
    iget-object v3, p0, Lchat/ola/vn/network/e$46;->b:Lchat/ola/vn/network/e;

    iget-object v3, v3, Lchat/ola/vn/network/e;->a:Lchat/ola/vn/network/OlaNetworkService;

    invoke-virtual {v3, v0, v2}, Lchat/ola/vn/network/OlaNetworkService;->w(Ljava/lang/String;S)V

    iget-object v0, p0, Lchat/ola/vn/network/e$46;->b:Lchat/ola/vn/network/e;

    iget-object v0, v0, Lchat/ola/vn/network/e;->a:Lchat/ola/vn/network/OlaNetworkService;

    const-string v3, "bmk"

    const/4 v4, 0x3

    new-array v4, v4, [Ljava/lang/String;

    const-string v5, "mehistory"

    aput-object v5, v4, v2

    const-string v5, "smileyhistory"

    aput-object v5, v4, v1

    const-string v5, "lastRoomId"

    const/4 v6, 0x2

    aput-object v5, v4, v6

    invoke-virtual {v0, v3, v4, v2}, Lchat/ola/vn/network/OlaNetworkService;->b(Ljava/lang/String;[Ljava/lang/String;S)V

    iget-object v0, p0, Lchat/ola/vn/network/e$46;->b:Lchat/ola/vn/network/e;

    iget-object v0, v0, Lchat/ola/vn/network/e;->a:Lchat/ola/vn/network/OlaNetworkService;

    const-string v3, "rss"

    new-array v4, v6, [Ljava/lang/String;

    const-string v5, "rssbookmark"

    aput-object v5, v4, v2

    const-string v5, "rsshistory"

    aput-object v5, v4, v1

    invoke-virtual {v0, v3, v4, v2}, Lchat/ola/vn/network/OlaNetworkService;->b(Ljava/lang/String;[Ljava/lang/String;S)V

    iget-object v0, p0, Lchat/ola/vn/network/e$46;->b:Lchat/ola/vn/network/e;

    iget-object v0, v0, Lchat/ola/vn/network/e;->a:Lchat/ola/vn/network/OlaNetworkService;

    const-string v3, "set"

    new-array v1, v1, [Ljava/lang/String;

    const-string v4, "usersettings"

    aput-object v4, v1, v2

    invoke-virtual {v0, v3, v1, v2}, Lchat/ola/vn/network/OlaNetworkService;->b(Ljava/lang/String;[Ljava/lang/String;S)V
    :try_end_2
    .catch Ljava/lang/Throwable; {:try_start_2 .. :try_end_2} :catch_2

    :catch_2
    return-void
.end method
