.class public Lchat/ola/vn/b/s;
.super Lchat/ola/vn/b/j;


# annotations
.annotation system Ldalvik/annotation/MemberClasses;
    value = {
        Lchat/ola/vn/b/s$a;
    }
.end annotation

.annotation system Ldalvik/annotation/Signature;
    value = {
        "Lchat/ola/vn/b/j<",
        "Lchat/ola/vn/entity/ab;",
        ">;"
    }
.end annotation


# instance fields
.field private a:Ljava/util/List;
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "Ljava/util/List<",
            "Lchat/ola/vn/entity/ab;",
            ">;"
        }
    .end annotation
.end field

.field private b:Z


# direct methods
.method public constructor <init>(Landroid/content/Context;)V
    .locals 0

    invoke-direct {p0, p1}, Lchat/ola/vn/b/j;-><init>(Landroid/content/Context;)V

    const/4 p1, 0x0

    iput-object p1, p0, Lchat/ola/vn/b/s;->a:Ljava/util/List;

    const/4 p1, 0x1

    iput-boolean p1, p0, Lchat/ola/vn/b/s;->b:Z

    return-void
.end method

.method private a(Lchat/ola/vn/entity/ab;)V
    .locals 2

    iget-object v0, p0, Lchat/ola/vn/b/s;->a:Ljava/util/List;

    if-nez v0, :cond_0

    new-instance v0, Ljava/util/ArrayList;

    const/16 v1, 0x64

    invoke-direct {v0, v1}, Ljava/util/ArrayList;-><init>(I)V

    iput-object v0, p0, Lchat/ola/vn/b/s;->a:Ljava/util/List;

    :cond_0
    iget-object v0, p0, Lchat/ola/vn/b/s;->a:Ljava/util/List;

    invoke-interface {v0, p1}, Ljava/util/List;->add(Ljava/lang/Object;)Z

    return-void
.end method

.method private a(Ljava/lang/String;B)V
    .locals 3

    :try_start_0
    iget-object v0, p0, Lchat/ola/vn/b/s;->a:Ljava/util/List;

    invoke-interface {v0}, Ljava/util/List;->iterator()Ljava/util/Iterator;

    move-result-object v0

    :cond_0
    invoke-interface {v0}, Ljava/util/Iterator;->hasNext()Z

    move-result v1

    if-eqz v1, :cond_1

    invoke-interface {v0}, Ljava/util/Iterator;->next()Ljava/lang/Object;

    move-result-object v1

    check-cast v1, Lchat/ola/vn/entity/ab;

    iget-byte v2, v1, Lchat/ola/vn/entity/ab;->b:B

    if-ne v2, p2, :cond_0

    iget-object v1, v1, Lchat/ola/vn/entity/ab;->c:Ljava/lang/String;

    invoke-static {v1, p1}, Lchat/ola/vn/util/m;->a(Ljava/lang/String;Ljava/lang/String;)Z

    move-result v1
    :try_end_0
    .catch Ljava/lang/Throwable; {:try_start_0 .. :try_end_0} :catch_0

    if-eqz v1, :cond_0

    return-void

    :catch_0
    :cond_1
    new-instance v0, Lchat/ola/vn/entity/ab;

    invoke-direct {v0}, Lchat/ola/vn/entity/ab;-><init>()V

    iput-byte p2, v0, Lchat/ola/vn/entity/ab;->b:B

    const/4 p2, 0x2

    iput-short p2, v0, Lchat/ola/vn/entity/ab;->a:S

    iput-object p1, v0, Lchat/ola/vn/entity/ab;->c:Ljava/lang/String;

    invoke-direct {p0, v0}, Lchat/ola/vn/b/s;->a(Lchat/ola/vn/entity/ab;)V

    return-void
.end method

.method static synthetic a(Lchat/ola/vn/b/s;)Z
    .locals 0

    iget-boolean p0, p0, Lchat/ola/vn/b/s;->b:Z

    return p0
.end method

.method static synthetic b(Lchat/ola/vn/b/s;)Ljava/util/List;
    .locals 0

    iget-object p0, p0, Lchat/ola/vn/b/s;->a:Ljava/util/List;

    return-object p0
.end method

.method private b(Ljava/lang/String;B)V
    .locals 3

    :try_start_0
    iget-object v0, p0, Lchat/ola/vn/b/s;->a:Ljava/util/List;

    invoke-interface {v0}, Ljava/util/List;->iterator()Ljava/util/Iterator;

    move-result-object v0

    :cond_0
    invoke-interface {v0}, Ljava/util/Iterator;->hasNext()Z

    move-result v1

    if-eqz v1, :cond_1

    invoke-interface {v0}, Ljava/util/Iterator;->next()Ljava/lang/Object;

    move-result-object v1

    check-cast v1, Lchat/ola/vn/entity/ab;

    iget-byte v2, v1, Lchat/ola/vn/entity/ab;->b:B

    if-ne v2, p2, :cond_0

    iget-object v1, v1, Lchat/ola/vn/entity/ab;->c:Ljava/lang/String;

    invoke-static {v1, p1}, Lchat/ola/vn/util/m;->a(Ljava/lang/String;Ljava/lang/String;)Z

    move-result v1
    :try_end_0
    .catch Ljava/lang/Throwable; {:try_start_0 .. :try_end_0} :catch_0

    if-eqz v1, :cond_0

    return-void

    :catch_0
    :cond_1
    new-instance v0, Lchat/ola/vn/entity/ab;

    invoke-direct {v0}, Lchat/ola/vn/entity/ab;-><init>()V

    iput-byte p2, v0, Lchat/ola/vn/entity/ab;->b:B

    const/4 p2, 0x1

    iput-short p2, v0, Lchat/ola/vn/entity/ab;->a:S

    iput-object p1, v0, Lchat/ola/vn/entity/ab;->c:Ljava/lang/String;

    invoke-direct {p0, v0}, Lchat/ola/vn/b/s;->a(Lchat/ola/vn/entity/ab;)V

    return-void
.end method


# virtual methods
.method public a(ILandroid/view/View;Landroid/view/ViewGroup;)Landroid/view/View;
    .locals 4

    if-nez p2, :cond_0

    :try_start_0
    iget-object v0, p0, Lchat/ola/vn/b/s;->e:Landroid/view/LayoutInflater;

    const v1, 0x7f0b015a

    const/4 v2, 0x0

    invoke-virtual {v0, v1, v2}, Landroid/view/LayoutInflater;->inflate(ILandroid/view/ViewGroup;)Landroid/view/View;

    move-result-object v0
    :try_end_0
    .catch Ljava/lang/Throwable; {:try_start_0 .. :try_end_0} :catch_0

    :try_start_1
    new-instance p2, Lchat/ola/vn/b/s$a;

    invoke-direct {p2, p0, v0}, Lchat/ola/vn/b/s$a;-><init>(Lchat/ola/vn/b/s;Landroid/view/View;)V

    invoke-virtual {v0, p2}, Landroid/view/View;->setTag(Ljava/lang/Object;)V
    :try_end_1
    .catch Ljava/lang/Throwable; {:try_start_1 .. :try_end_1} :catch_1

    goto :goto_0

    :catch_0
    move-object v0, p2

    goto :goto_1

    :cond_0
    :try_start_2
    invoke-virtual {p2}, Landroid/view/View;->getTag()Ljava/lang/Object;

    move-result-object v0

    check-cast v0, Lchat/ola/vn/b/s$a;
    :try_end_2
    .catch Ljava/lang/Throwable; {:try_start_2 .. :try_end_2} :catch_0

    move-object v3, v0

    move-object v0, p2

    move-object p2, v3

    :goto_0
    :try_start_3
    invoke-virtual {p0, p1}, Lchat/ola/vn/b/s;->a(I)Lchat/ola/vn/entity/ab;

    move-result-object p1

    invoke-virtual {p2, p1}, Lchat/ola/vn/b/s$a;->a(Lchat/ola/vn/entity/ab;)V
    :try_end_3
    .catch Ljava/lang/Throwable; {:try_start_3 .. :try_end_3} :catch_1

    :catch_1
    :goto_1
    if-nez v0, :cond_1

    return-object p3

    :cond_1
    return-object v0
.end method

.method public a(I)Lchat/ola/vn/entity/ab;
    .locals 1

    :try_start_0
    iget-object v0, p0, Lchat/ola/vn/b/s;->a:Ljava/util/List;

    invoke-interface {v0, p1}, Ljava/util/List;->get(I)Ljava/lang/Object;

    move-result-object p1

    check-cast p1, Lchat/ola/vn/entity/ab;
    :try_end_0
    .catch Ljava/lang/Throwable; {:try_start_0 .. :try_end_0} :catch_0

    return-object p1

    :catch_0
    const/4 p1, 0x0

    return-object p1
.end method

.method public a()Ljava/util/List;
    .locals 2
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "()",
            "Ljava/util/List<",
            "Lchat/ola/vn/entity/ab;",
            ">;"
        }
    .end annotation

    :try_start_0
    new-instance v0, Ljava/util/ArrayList;

    iget-object v1, p0, Lchat/ola/vn/b/s;->a:Ljava/util/List;

    invoke-direct {v0, v1}, Ljava/util/ArrayList;-><init>(Ljava/util/Collection;)V
    :try_end_0
    .catch Ljava/lang/Throwable; {:try_start_0 .. :try_end_0} :catch_0

    return-object v0

    :catch_0
    const/4 v0, 0x0

    return-object v0
.end method

.method public a(Ljava/lang/String;)V
    .locals 1

    const/4 v0, 0x0

    invoke-direct {p0, p1, v0}, Lchat/ola/vn/b/s;->b(Ljava/lang/String;B)V

    return-void
.end method

.method public a(Ljava/util/List;)V
    .locals 3
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "(",
            "Ljava/util/List<",
            "Lchat/ola/vn/entity/ab;",
            ">;)V"
        }
    .end annotation

    const/4 v0, 0x0

    :try_start_0
    invoke-interface {p1}, Ljava/util/List;->size()I

    move-result v1

    :goto_0
    if-ge v0, v1, :cond_0

    invoke-interface {p1, v0}, Ljava/util/List;->get(I)Ljava/lang/Object;

    move-result-object v2

    check-cast v2, Lchat/ola/vn/entity/ab;

    invoke-direct {p0, v2}, Lchat/ola/vn/b/s;->a(Lchat/ola/vn/entity/ab;)V
    :try_end_0
    .catch Ljava/lang/Throwable; {:try_start_0 .. :try_end_0} :catch_0

    add-int/lit8 v0, v0, 0x1

    goto :goto_0

    :catch_0
    :cond_0
    return-void
.end method

.method public a(Z)V
    .locals 0

    iput-boolean p1, p0, Lchat/ola/vn/b/s;->b:Z

    return-void
.end method

.method public b(Ljava/lang/String;)V
    .locals 1

    const/4 v0, 0x0

    invoke-direct {p0, p1, v0}, Lchat/ola/vn/b/s;->a(Ljava/lang/String;B)V

    return-void
.end method

.method public c()V
    .locals 2

    const/4 v0, 0x0

    :try_start_0
    iget-object v1, p0, Lchat/ola/vn/b/s;->a:Ljava/util/List;

    invoke-interface {v1}, Ljava/util/List;->clear()V
    :try_end_0
    .catch Ljava/lang/Throwable; {:try_start_0 .. :try_end_0} :catch_0
    .catchall {:try_start_0 .. :try_end_0} :catchall_0

    goto :goto_0

    :catchall_0
    move-exception v1

    iput-object v0, p0, Lchat/ola/vn/b/s;->a:Ljava/util/List;

    throw v1

    :catch_0
    :goto_0
    iput-object v0, p0, Lchat/ola/vn/b/s;->a:Ljava/util/List;

    return-void
.end method

.method public c(Ljava/lang/String;)V
    .locals 1

    const/4 v0, 0x1

    invoke-direct {p0, p1, v0}, Lchat/ola/vn/b/s;->b(Ljava/lang/String;B)V

    return-void
.end method

.method public d(Ljava/lang/String;)V
    .locals 1

    const/4 v0, 0x1

    invoke-direct {p0, p1, v0}, Lchat/ola/vn/b/s;->a(Ljava/lang/String;B)V

    return-void
.end method

.method public d()Z
    .locals 2

    const/4 v0, 0x0

    :try_start_0
    iget-object v1, p0, Lchat/ola/vn/b/s;->a:Ljava/util/List;

    invoke-interface {v1}, Ljava/util/List;->size()I

    move-result v1
    :try_end_0
    .catch Ljava/lang/Throwable; {:try_start_0 .. :try_end_0} :catch_0

    if-lez v1, :cond_0

    const/4 v0, 0x1

    :catch_0
    :cond_0
    return v0
.end method

.method public getCount()I
    .locals 1

    :try_start_0
    iget-object v0, p0, Lchat/ola/vn/b/s;->a:Ljava/util/List;

    invoke-interface {v0}, Ljava/util/List;->size()I

    move-result v0
    :try_end_0
    .catch Ljava/lang/Throwable; {:try_start_0 .. :try_end_0} :catch_0

    return v0

    :catch_0
    const/4 v0, 0x0

    return v0
.end method

.method public synthetic getItem(I)Ljava/lang/Object;
    .locals 0

    invoke-virtual {p0, p1}, Lchat/ola/vn/b/s;->a(I)Lchat/ola/vn/entity/ab;

    move-result-object p1

    return-object p1
.end method
