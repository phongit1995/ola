.class public Lchat/ola/vn/cloud/a;
.super Lchat/ola/vn/b/j;


# annotations
.annotation system Ldalvik/annotation/MemberClasses;
    value = {
        Lchat/ola/vn/cloud/a$a;
    }
.end annotation

.annotation system Ldalvik/annotation/Signature;
    value = {
        "Lchat/ola/vn/b/j<",
        "Lchat/ola/vn/entity/l;",
        ">;"
    }
.end annotation


# instance fields
.field protected a:Landroid/view/LayoutInflater;

.field protected b:Lchat/ola/vn/cloud/d;

.field private c:B

.field private d:Ljava/util/List;
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "Ljava/util/List<",
            "Lchat/ola/vn/entity/l;",
            ">;"
        }
    .end annotation
.end field

.field private g:Z


# direct methods
.method public constructor <init>(Landroid/content/Context;)V
    .locals 1

    invoke-direct {p0, p1}, Lchat/ola/vn/b/j;-><init>(Landroid/content/Context;)V

    const/4 v0, 0x0

    iput-byte v0, p0, Lchat/ola/vn/cloud/a;->c:B

    const/4 v0, 0x1

    iput-boolean v0, p0, Lchat/ola/vn/cloud/a;->g:Z

    invoke-static {p1}, Landroid/view/LayoutInflater;->from(Landroid/content/Context;)Landroid/view/LayoutInflater;

    move-result-object p1

    iput-object p1, p0, Lchat/ola/vn/cloud/a;->a:Landroid/view/LayoutInflater;

    return-void
.end method

.method static synthetic a(Lchat/ola/vn/cloud/a;)B
    .locals 0

    iget-byte p0, p0, Lchat/ola/vn/cloud/a;->c:B

    return p0
.end method

.method static synthetic b(Lchat/ola/vn/cloud/a;)Z
    .locals 0

    iget-boolean p0, p0, Lchat/ola/vn/cloud/a;->g:Z

    return p0
.end method

.method static synthetic c(Lchat/ola/vn/cloud/a;)Ljava/util/List;
    .locals 0

    iget-object p0, p0, Lchat/ola/vn/cloud/a;->d:Ljava/util/List;

    return-object p0
.end method

.method private g()V
    .locals 2

    iget-object v0, p0, Lchat/ola/vn/cloud/a;->d:Ljava/util/List;

    new-instance v1, Lchat/ola/vn/cloud/a$1;

    invoke-direct {v1, p0}, Lchat/ola/vn/cloud/a$1;-><init>(Lchat/ola/vn/cloud/a;)V

    invoke-static {v0, v1}, Ljava/util/Collections;->sort(Ljava/util/List;Ljava/util/Comparator;)V

    return-void
.end method


# virtual methods
.method public a(ILandroid/view/View;Landroid/view/ViewGroup;)Landroid/view/View;
    .locals 3

    if-nez p2, :cond_0

    :try_start_0
    iget-object p3, p0, Lchat/ola/vn/cloud/a;->a:Landroid/view/LayoutInflater;

    const v0, 0x7f0b014a

    const/4 v1, 0x0

    invoke-virtual {p3, v0, v1}, Landroid/view/LayoutInflater;->inflate(ILandroid/view/ViewGroup;)Landroid/view/View;

    move-result-object p3
    :try_end_0
    .catch Ljava/lang/Throwable; {:try_start_0 .. :try_end_0} :catch_1

    :try_start_1
    new-instance p2, Lchat/ola/vn/cloud/a$a;

    invoke-direct {p2, p0, p3}, Lchat/ola/vn/cloud/a$a;-><init>(Lchat/ola/vn/cloud/a;Landroid/view/View;)V

    invoke-virtual {p3, p2}, Landroid/view/View;->setTag(Ljava/lang/Object;)V
    :try_end_1
    .catch Ljava/lang/Throwable; {:try_start_1 .. :try_end_1} :catch_0

    goto :goto_0

    :catch_0
    move-exception p1

    goto :goto_1

    :catch_1
    move-exception p1

    move-object p3, p2

    goto :goto_1

    :cond_0
    :try_start_2
    invoke-virtual {p2}, Landroid/view/View;->getTag()Ljava/lang/Object;

    move-result-object p3
    :try_end_2
    .catch Ljava/lang/Throwable; {:try_start_2 .. :try_end_2} :catch_1

    :try_start_3
    check-cast p3, Lchat/ola/vn/cloud/a$a;
    :try_end_3
    .catch Ljava/lang/Throwable; {:try_start_3 .. :try_end_3} :catch_2

    move-object v2, p3

    move-object p3, p2

    move-object p2, v2

    goto :goto_0

    :catch_2
    move-exception p3

    :try_start_4
    new-instance v0, Lchat/ola/vn/cloud/a$a;

    invoke-direct {v0, p0, p2}, Lchat/ola/vn/cloud/a$a;-><init>(Lchat/ola/vn/cloud/a;Landroid/view/View;)V

    invoke-virtual {p2, v0}, Landroid/view/View;->setTag(Ljava/lang/Object;)V

    invoke-virtual {p3}, Ljava/lang/Throwable;->printStackTrace()V
    :try_end_4
    .catch Ljava/lang/Throwable; {:try_start_4 .. :try_end_4} :catch_1

    move-object p3, p2

    move-object p2, v0

    :goto_0
    :try_start_5
    iget-object v0, p0, Lchat/ola/vn/cloud/a;->d:Ljava/util/List;

    invoke-interface {v0, p1}, Ljava/util/List;->get(I)Ljava/lang/Object;

    move-result-object p1

    check-cast p1, Lchat/ola/vn/entity/l;

    invoke-virtual {p2, p1}, Lchat/ola/vn/cloud/a$a;->a(Lchat/ola/vn/entity/l;)V
    :try_end_5
    .catch Ljava/lang/Throwable; {:try_start_5 .. :try_end_5} :catch_0

    return-object p3

    :goto_1
    invoke-virtual {p1}, Ljava/lang/Throwable;->printStackTrace()V

    return-object p3
.end method

.method public a(I)Lchat/ola/vn/entity/l;
    .locals 1

    :try_start_0
    iget-object v0, p0, Lchat/ola/vn/cloud/a;->d:Ljava/util/List;

    invoke-interface {v0, p1}, Ljava/util/List;->get(I)Ljava/lang/Object;

    move-result-object p1

    check-cast p1, Lchat/ola/vn/entity/l;
    :try_end_0
    .catch Ljava/lang/Throwable; {:try_start_0 .. :try_end_0} :catch_0

    return-object p1

    :catch_0
    move-exception p1

    invoke-virtual {p1}, Ljava/lang/Throwable;->printStackTrace()V

    const/4 p1, 0x0

    return-object p1
.end method

.method public a()Ljava/util/List;
    .locals 4
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "()",
            "Ljava/util/List<",
            "Lchat/ola/vn/entity/l;",
            ">;"
        }
    .end annotation

    const/4 v0, 0x0

    :try_start_0
    iget-object v1, p0, Lchat/ola/vn/cloud/a;->d:Ljava/util/List;

    invoke-interface {v1}, Ljava/util/List;->iterator()Ljava/util/Iterator;

    move-result-object v1

    :cond_0
    :goto_0
    invoke-interface {v1}, Ljava/util/Iterator;->hasNext()Z

    move-result v2

    if-eqz v2, :cond_2

    invoke-interface {v1}, Ljava/util/Iterator;->next()Ljava/lang/Object;

    move-result-object v2

    check-cast v2, Lchat/ola/vn/entity/l;

    iget-boolean v3, v2, Lchat/ola/vn/entity/l;->k:Z

    if-eqz v3, :cond_0

    if-nez v0, :cond_1

    new-instance v3, Ljava/util/ArrayList;

    invoke-direct {v3}, Ljava/util/ArrayList;-><init>()V

    move-object v0, v3

    :cond_1
    invoke-interface {v0, v2}, Ljava/util/List;->add(Ljava/lang/Object;)Z
    :try_end_0
    .catch Ljava/lang/Throwable; {:try_start_0 .. :try_end_0} :catch_0

    goto :goto_0

    :catch_0
    :cond_2
    return-object v0
.end method

.method public a(Lchat/ola/vn/cloud/d;)V
    .locals 0

    iput-object p1, p0, Lchat/ola/vn/cloud/a;->b:Lchat/ola/vn/cloud/d;

    return-void
.end method

.method public a(Ljava/util/List;)V
    .locals 1
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "(",
            "Ljava/util/List<",
            "Lchat/ola/vn/entity/l;",
            ">;)V"
        }
    .end annotation

    iget-object v0, p0, Lchat/ola/vn/cloud/a;->d:Ljava/util/List;

    if-nez v0, :cond_0

    new-instance v0, Ljava/util/ArrayList;

    invoke-direct {v0, p1}, Ljava/util/ArrayList;-><init>(Ljava/util/Collection;)V

    iput-object v0, p0, Lchat/ola/vn/cloud/a;->d:Ljava/util/List;

    goto :goto_0

    :cond_0
    iget-object v0, p0, Lchat/ola/vn/cloud/a;->d:Ljava/util/List;

    invoke-interface {v0, p1}, Ljava/util/List;->addAll(Ljava/util/Collection;)Z

    :goto_0
    invoke-direct {p0}, Lchat/ola/vn/cloud/a;->g()V

    invoke-virtual {p0}, Lchat/ola/vn/cloud/a;->notifyDataSetChanged()V

    return-void
.end method

.method public a(Z)V
    .locals 0

    iput-boolean p1, p0, Lchat/ola/vn/cloud/a;->g:Z

    return-void
.end method

.method public b(Ljava/util/List;)V
    .locals 1
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "(",
            "Ljava/util/List<",
            "Lchat/ola/vn/entity/l;",
            ">;)V"
        }
    .end annotation

    :try_start_0
    new-instance v0, Ljava/util/ArrayList;

    invoke-direct {v0, p1}, Ljava/util/ArrayList;-><init>(Ljava/util/Collection;)V

    iput-object v0, p0, Lchat/ola/vn/cloud/a;->d:Ljava/util/List;

    invoke-direct {p0}, Lchat/ola/vn/cloud/a;->g()V
    :try_end_0
    .catch Ljava/lang/Throwable; {:try_start_0 .. :try_end_0} :catch_0

    return-void

    :catch_0
    move-exception p1

    invoke-virtual {p1}, Ljava/lang/Throwable;->printStackTrace()V

    return-void
.end method

.method public c()Z
    .locals 2

    iget-byte v0, p0, Lchat/ola/vn/cloud/a;->c:B

    const/4 v1, 0x1

    if-ne v0, v1, :cond_0

    return v1

    :cond_0
    const/4 v1, 0x0

    return v1
.end method

.method public d()V
    .locals 2

    iget-byte v0, p0, Lchat/ola/vn/cloud/a;->c:B

    const/4 v1, 0x1

    if-eq v0, v1, :cond_0

    iput-byte v1, p0, Lchat/ola/vn/cloud/a;->c:B

    invoke-virtual {p0}, Lchat/ola/vn/cloud/a;->notifyDataSetChanged()V

    iget-object v0, p0, Lchat/ola/vn/cloud/a;->b:Lchat/ola/vn/cloud/d;

    if-eqz v0, :cond_0

    iget-object v0, p0, Lchat/ola/vn/cloud/a;->b:Lchat/ola/vn/cloud/d;

    invoke-interface {v0}, Lchat/ola/vn/cloud/d;->C()V

    :cond_0
    return-void
.end method

.method public e()V
    .locals 3

    iget-byte v0, p0, Lchat/ola/vn/cloud/a;->c:B

    if-eqz v0, :cond_2

    const/4 v0, 0x0

    iput-byte v0, p0, Lchat/ola/vn/cloud/a;->c:B

    :try_start_0
    iget-object v1, p0, Lchat/ola/vn/cloud/a;->d:Ljava/util/List;

    invoke-interface {v1}, Ljava/util/List;->iterator()Ljava/util/Iterator;

    move-result-object v1

    :goto_0
    invoke-interface {v1}, Ljava/util/Iterator;->hasNext()Z

    move-result v2

    if-eqz v2, :cond_0

    invoke-interface {v1}, Ljava/util/Iterator;->next()Ljava/lang/Object;

    move-result-object v2

    check-cast v2, Lchat/ola/vn/entity/l;

    iput-boolean v0, v2, Lchat/ola/vn/entity/l;->k:Z

    goto :goto_0

    :cond_0
    iget-object v0, p0, Lchat/ola/vn/cloud/a;->b:Lchat/ola/vn/cloud/d;

    if-eqz v0, :cond_1

    iget-object v0, p0, Lchat/ola/vn/cloud/a;->b:Lchat/ola/vn/cloud/d;

    invoke-interface {v0}, Lchat/ola/vn/cloud/d;->D()V
    :try_end_0
    .catch Ljava/lang/Throwable; {:try_start_0 .. :try_end_0} :catch_0

    :catch_0
    :cond_1
    invoke-virtual {p0}, Lchat/ola/vn/cloud/a;->notifyDataSetChanged()V

    :cond_2
    return-void
.end method

.method public f()Ljava/util/List;
    .locals 1
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "()",
            "Ljava/util/List<",
            "Lchat/ola/vn/entity/l;",
            ">;"
        }
    .end annotation

    :try_start_0
    iget-object v0, p0, Lchat/ola/vn/cloud/a;->d:Ljava/util/List;
    :try_end_0
    .catch Ljava/lang/Throwable; {:try_start_0 .. :try_end_0} :catch_0

    return-object v0

    :catch_0
    move-exception v0

    invoke-virtual {v0}, Ljava/lang/Throwable;->printStackTrace()V

    const/4 v0, 0x0

    return-object v0
.end method

.method public getCount()I
    .locals 1

    :try_start_0
    iget-object v0, p0, Lchat/ola/vn/cloud/a;->d:Ljava/util/List;

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

    invoke-virtual {p0, p1}, Lchat/ola/vn/cloud/a;->a(I)Lchat/ola/vn/entity/l;

    move-result-object p1

    return-object p1
.end method

.method public getItemViewType(I)I
    .locals 0

    const/4 p1, 0x0

    return p1
.end method

.method public getViewTypeCount()I
    .locals 1

    const/4 v0, 0x1

    return v0
.end method
