.class public Lchat/ola/vn/game/caro/b;
.super Ljava/lang/Object;


# static fields
.field public static a:I = 0x28

.field public static b:I = 0x28


# instance fields
.field private c:I

.field private d:I

.field private e:[[I

.field private f:Lchat/ola/vn/game/caro/a;

.field private g:Lchat/ola/vn/game/caro/c;

.field private h:Z

.field private i:Z

.field private j:S


# direct methods
.method static constructor <clinit>()V
    .locals 0

    return-void
.end method


# virtual methods
.method public a()I
    .locals 1

    iget v0, p0, Lchat/ola/vn/game/caro/b;->c:I

    return v0
.end method

.method public a(IIS)V
    .locals 2

    :try_start_0
    iget-object v0, p0, Lchat/ola/vn/game/caro/b;->e:[[I

    aget-object v0, v0, p1

    aput p3, v0, p2

    new-instance v0, Lchat/ola/vn/game/caro/a;

    invoke-direct {v0, p1, p2, p3}, Lchat/ola/vn/game/caro/a;-><init>(IIS)V

    iput-object v0, p0, Lchat/ola/vn/game/caro/b;->f:Lchat/ola/vn/game/caro/a;

    iget-object v0, p0, Lchat/ola/vn/game/caro/b;->g:Lchat/ola/vn/game/caro/c;

    if-eqz v0, :cond_0

    iget-object v0, p0, Lchat/ola/vn/game/caro/b;->g:Lchat/ola/vn/game/caro/c;

    new-instance v1, Lchat/ola/vn/game/caro/a;

    invoke-direct {v1, p1, p2, p3}, Lchat/ola/vn/game/caro/a;-><init>(IIS)V

    invoke-interface {v0, v1}, Lchat/ola/vn/game/caro/c;->a(Lchat/ola/vn/game/caro/a;)V
    :try_end_0
    .catch Ljava/lang/Throwable; {:try_start_0 .. :try_end_0} :catch_0

    return-void

    :catch_0
    move-exception p1

    invoke-virtual {p1}, Ljava/lang/Throwable;->printStackTrace()V

    :cond_0
    return-void
.end method

.method public a(Lchat/ola/vn/game/caro/c;)V
    .locals 0

    iput-object p1, p0, Lchat/ola/vn/game/caro/b;->g:Lchat/ola/vn/game/caro/c;

    return-void
.end method

.method public a(Z)V
    .locals 0

    iput-boolean p1, p0, Lchat/ola/vn/game/caro/b;->h:Z

    return-void
.end method

.method public b()I
    .locals 1

    iget v0, p0, Lchat/ola/vn/game/caro/b;->d:I

    return v0
.end method

.method public b(Z)V
    .locals 0

    iput-boolean p1, p0, Lchat/ola/vn/game/caro/b;->i:Z

    return-void
.end method

.method public c()Ljava/util/List;
    .locals 6
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "()",
            "Ljava/util/List<",
            "Lchat/ola/vn/game/caro/a;",
            ">;"
        }
    .end annotation

    :try_start_0
    new-instance v0, Ljava/util/ArrayList;

    const/4 v1, 0x0

    invoke-direct {v0, v1}, Ljava/util/ArrayList;-><init>(I)V

    const/4 v2, 0x0

    :goto_0
    iget v3, p0, Lchat/ola/vn/game/caro/b;->c:I

    if-ge v2, v3, :cond_2

    const/4 v3, 0x0

    :goto_1
    iget v4, p0, Lchat/ola/vn/game/caro/b;->d:I

    if-ge v3, v4, :cond_1

    iget-object v4, p0, Lchat/ola/vn/game/caro/b;->e:[[I

    aget-object v4, v4, v2

    aget v4, v4, v3

    sget-short v5, Lchat/ola/vn/game/caro/a;->b:S

    if-ne v4, v5, :cond_0

    new-instance v4, Lchat/ola/vn/game/caro/a;

    sget-short v5, Lchat/ola/vn/game/caro/a;->b:S

    invoke-direct {v4, v2, v3, v5}, Lchat/ola/vn/game/caro/a;-><init>(IIS)V

    invoke-interface {v0, v4}, Ljava/util/List;->add(Ljava/lang/Object;)Z
    :try_end_0
    .catch Ljava/lang/Throwable; {:try_start_0 .. :try_end_0} :catch_0

    :cond_0
    add-int/lit8 v3, v3, 0x1

    goto :goto_1

    :cond_1
    add-int/lit8 v2, v2, 0x1

    goto :goto_0

    :cond_2
    return-object v0

    :catch_0
    const/4 v0, 0x0

    return-object v0
.end method

.method public d()Ljava/util/List;
    .locals 6
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "()",
            "Ljava/util/List<",
            "Lchat/ola/vn/game/caro/a;",
            ">;"
        }
    .end annotation

    :try_start_0
    new-instance v0, Ljava/util/ArrayList;

    const/4 v1, 0x0

    invoke-direct {v0, v1}, Ljava/util/ArrayList;-><init>(I)V

    const/4 v2, 0x0

    :goto_0
    iget v3, p0, Lchat/ola/vn/game/caro/b;->c:I

    if-ge v2, v3, :cond_2

    const/4 v3, 0x0

    :goto_1
    iget v4, p0, Lchat/ola/vn/game/caro/b;->d:I

    if-ge v3, v4, :cond_1

    iget-object v4, p0, Lchat/ola/vn/game/caro/b;->e:[[I

    aget-object v4, v4, v2

    aget v4, v4, v3

    sget-short v5, Lchat/ola/vn/game/caro/a;->a:S

    if-ne v4, v5, :cond_0

    new-instance v4, Lchat/ola/vn/game/caro/a;

    sget-short v5, Lchat/ola/vn/game/caro/a;->a:S

    invoke-direct {v4, v2, v3, v5}, Lchat/ola/vn/game/caro/a;-><init>(IIS)V

    invoke-interface {v0, v4}, Ljava/util/List;->add(Ljava/lang/Object;)Z
    :try_end_0
    .catch Ljava/lang/Throwable; {:try_start_0 .. :try_end_0} :catch_0

    :cond_0
    add-int/lit8 v3, v3, 0x1

    goto :goto_1

    :cond_1
    add-int/lit8 v2, v2, 0x1

    goto :goto_0

    :cond_2
    return-object v0

    :catch_0
    const/4 v0, 0x0

    return-object v0
.end method

.method public e()Lchat/ola/vn/game/caro/a;
    .locals 1

    iget-object v0, p0, Lchat/ola/vn/game/caro/b;->f:Lchat/ola/vn/game/caro/a;

    return-object v0
.end method

.method public f()Z
    .locals 1

    iget-boolean v0, p0, Lchat/ola/vn/game/caro/b;->h:Z

    return v0
.end method

.method public g()Z
    .locals 1

    iget-boolean v0, p0, Lchat/ola/vn/game/caro/b;->i:Z

    return v0
.end method

.method public h()V
    .locals 1

    iget-object v0, p0, Lchat/ola/vn/game/caro/b;->g:Lchat/ola/vn/game/caro/c;

    if-eqz v0, :cond_0

    iget-object v0, p0, Lchat/ola/vn/game/caro/b;->g:Lchat/ola/vn/game/caro/c;

    invoke-interface {v0}, Lchat/ola/vn/game/caro/c;->B()V

    :cond_0
    invoke-virtual {p0}, Lchat/ola/vn/game/caro/b;->i()V

    return-void
.end method

.method public i()V
    .locals 2

    const/4 v0, 0x0

    move-object v1, v0

    check-cast v1, [[I

    iput-object v1, p0, Lchat/ola/vn/game/caro/b;->e:[[I

    const/4 v1, 0x0

    iput v1, p0, Lchat/ola/vn/game/caro/b;->c:I

    iput v1, p0, Lchat/ola/vn/game/caro/b;->d:I

    iput-object v0, p0, Lchat/ola/vn/game/caro/b;->f:Lchat/ola/vn/game/caro/a;

    iput-object v0, p0, Lchat/ola/vn/game/caro/b;->g:Lchat/ola/vn/game/caro/c;

    return-void
.end method

.method public j()V
    .locals 2

    iget v0, p0, Lchat/ola/vn/game/caro/b;->c:I

    iget v1, p0, Lchat/ola/vn/game/caro/b;->d:I

    filled-new-array {v0, v1}, [I

    move-result-object v0

    const-class v1, I

    invoke-static {v1, v0}, Ljava/lang/reflect/Array;->newInstance(Ljava/lang/Class;[I)Ljava/lang/Object;

    move-result-object v0

    check-cast v0, [[I

    iput-object v0, p0, Lchat/ola/vn/game/caro/b;->e:[[I

    const/4 v0, 0x0

    iput-object v0, p0, Lchat/ola/vn/game/caro/b;->f:Lchat/ola/vn/game/caro/a;

    return-void
.end method

.method public k()[[I
    .locals 1

    iget-object v0, p0, Lchat/ola/vn/game/caro/b;->e:[[I

    return-object v0
.end method

.method public l()S
    .locals 1

    iget-short v0, p0, Lchat/ola/vn/game/caro/b;->j:S

    return v0
.end method
