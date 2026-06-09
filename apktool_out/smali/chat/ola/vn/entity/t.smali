.class public Lchat/ola/vn/entity/t;
.super Lchat/ola/vn/entity/ad;


# annotations
.annotation build Landroid/annotation/SuppressLint;
    value = {
        "DefaultLocale"
    }
.end annotation


# instance fields
.field private A:Z

.field private B:Ljava/lang/String;

.field private C:J

.field private u:Z

.field private v:Ljava/util/List;
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "Ljava/util/List<",
            "Lchat/ola/vn/entity/t;",
            ">;"
        }
    .end annotation
.end field

.field private w:Ljava/util/List;
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "Ljava/util/List<",
            "Lchat/ola/vn/entry/c;",
            ">;"
        }
    .end annotation
.end field

.field private x:Ljava/util/List;
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "Ljava/util/List<",
            "Lchat/ola/vn/entry/b;",
            ">;"
        }
    .end annotation
.end field

.field private y:Ljava/lang/String;

.field private z:J


# direct methods
.method public constructor <init>(Lchat/ola/vn/entity/ad;)V
    .locals 1

    const/4 v0, 0x0

    invoke-direct {p0, p1, v0}, Lchat/ola/vn/entity/t;-><init>(Lchat/ola/vn/entity/ad;Ljava/util/List;)V

    return-void
.end method

.method public constructor <init>(Lchat/ola/vn/entity/ad;Ljava/util/List;)V
    .locals 2
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "(",
            "Lchat/ola/vn/entity/ad;",
            "Ljava/util/List<",
            "Lchat/ola/vn/entity/t;",
            ">;)V"
        }
    .end annotation

    invoke-direct {p0}, Lchat/ola/vn/entity/ad;-><init>()V

    const-wide/16 v0, -0x1

    iput-wide v0, p0, Lchat/ola/vn/entity/t;->z:J

    const/4 v0, 0x1

    iput-boolean v0, p0, Lchat/ola/vn/entity/t;->A:Z

    invoke-virtual {p0, p1}, Lchat/ola/vn/entity/t;->a(Lchat/ola/vn/entity/ad;)V

    iput-object p2, p0, Lchat/ola/vn/entity/t;->v:Ljava/util/List;

    return-void
.end method

.method public constructor <init>(Ljava/lang/String;)V
    .locals 2

    invoke-direct {p0}, Lchat/ola/vn/entity/ad;-><init>()V

    const-wide/16 v0, -0x1

    iput-wide v0, p0, Lchat/ola/vn/entity/t;->z:J

    const/4 v0, 0x1

    iput-boolean v0, p0, Lchat/ola/vn/entity/t;->A:Z

    iput-object p1, p0, Lchat/ola/vn/entity/t;->d:Ljava/lang/String;

    const/4 p1, 0x0

    iput-boolean p1, p0, Lchat/ola/vn/entity/t;->u:Z

    return-void
.end method

.method public static c(Ljava/util/List;)Ljava/util/List;
    .locals 3
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "(",
            "Ljava/util/List<",
            "Lchat/ola/vn/entity/ad;",
            ">;)",
            "Ljava/util/List<",
            "Lchat/ola/vn/entity/t;",
            ">;"
        }
    .end annotation

    if-eqz p0, :cond_2

    invoke-interface {p0}, Ljava/util/List;->isEmpty()Z

    move-result v0

    if-eqz v0, :cond_0

    goto :goto_1

    :cond_0
    new-instance v0, Ljava/util/ArrayList;

    invoke-direct {v0}, Ljava/util/ArrayList;-><init>()V

    invoke-interface {p0}, Ljava/util/List;->iterator()Ljava/util/Iterator;

    move-result-object p0

    :goto_0
    invoke-interface {p0}, Ljava/util/Iterator;->hasNext()Z

    move-result v1

    if-eqz v1, :cond_1

    invoke-interface {p0}, Ljava/util/Iterator;->next()Ljava/lang/Object;

    move-result-object v1

    check-cast v1, Lchat/ola/vn/entity/ad;

    new-instance v2, Lchat/ola/vn/entity/t;

    invoke-direct {v2, v1}, Lchat/ola/vn/entity/t;-><init>(Lchat/ola/vn/entity/ad;)V

    invoke-interface {v0, v2}, Ljava/util/List;->add(Ljava/lang/Object;)Z

    goto :goto_0

    :cond_1
    return-object v0

    :cond_2
    :goto_1
    const/4 p0, 0x0

    return-object p0
.end method


# virtual methods
.method public a()J
    .locals 2

    iget-wide v0, p0, Lchat/ola/vn/entity/t;->z:J

    return-wide v0
.end method

.method public a(I)Lchat/ola/vn/entity/t;
    .locals 1

    iget-object v0, p0, Lchat/ola/vn/entity/t;->v:Ljava/util/List;

    if-nez v0, :cond_0

    const/4 p1, 0x0

    return-object p1

    :cond_0
    iget-object v0, p0, Lchat/ola/vn/entity/t;->v:Ljava/util/List;

    invoke-interface {v0, p1}, Ljava/util/List;->get(I)Ljava/lang/Object;

    move-result-object p1

    check-cast p1, Lchat/ola/vn/entity/t;

    return-object p1
.end method

.method public a(J)V
    .locals 0

    iput-wide p1, p0, Lchat/ola/vn/entity/t;->C:J

    return-void
.end method

.method public a(Landroid/widget/ListView;)V
    .locals 2

    const/4 v0, 0x0

    :try_start_0
    invoke-virtual {p1, v0}, Landroid/widget/ListView;->getChildAt(I)Landroid/view/View;

    move-result-object v1

    if-nez v1, :cond_0

    goto :goto_0

    :cond_0
    invoke-virtual {v1}, Landroid/view/View;->getTop()I

    move-result v0

    :goto_0
    iput v0, p0, Lchat/ola/vn/entity/t;->s:I

    invoke-virtual {p1}, Landroid/widget/ListView;->getFirstVisiblePosition()I

    move-result p1

    iput p1, p0, Lchat/ola/vn/entity/t;->t:I
    :try_end_0
    .catch Ljava/lang/Throwable; {:try_start_0 .. :try_end_0} :catch_0

    :catch_0
    return-void
.end method

.method public a(Lchat/ola/vn/entity/ad;)V
    .locals 2

    invoke-virtual {p1}, Lchat/ola/vn/entity/ad;->p()Ljava/lang/String;

    move-result-object v0

    iput-object v0, p0, Lchat/ola/vn/entity/t;->c:Ljava/lang/String;

    invoke-virtual {p1}, Lchat/ola/vn/entity/ad;->o()Ljava/lang/String;

    move-result-object v0

    iput-object v0, p0, Lchat/ola/vn/entity/t;->d:Ljava/lang/String;

    invoke-virtual {p1}, Lchat/ola/vn/entity/ad;->q()[Ljava/lang/String;

    move-result-object v0

    iput-object v0, p0, Lchat/ola/vn/entity/t;->e:[Ljava/lang/String;

    invoke-virtual {p1}, Lchat/ola/vn/entity/ad;->u()Ljava/lang/String;

    move-result-object v0

    iput-object v0, p0, Lchat/ola/vn/entity/t;->f:Ljava/lang/String;

    invoke-virtual {p1}, Lchat/ola/vn/entity/ad;->r()J

    move-result-wide v0

    iput-wide v0, p0, Lchat/ola/vn/entity/t;->k:J

    invoke-virtual {p1}, Lchat/ola/vn/entity/ad;->s()I

    move-result v0

    iput v0, p0, Lchat/ola/vn/entity/t;->n:I

    invoke-virtual {p1}, Lchat/ola/vn/entity/ad;->t()I

    move-result v0

    iput v0, p0, Lchat/ola/vn/entity/t;->o:I

    invoke-virtual {p1}, Lchat/ola/vn/entity/ad;->v()S

    move-result v0

    iput-short v0, p0, Lchat/ola/vn/entity/t;->q:S

    invoke-virtual {p1}, Lchat/ola/vn/entity/ad;->n()Ljava/lang/String;

    move-result-object v0

    iput-object v0, p0, Lchat/ola/vn/entity/t;->g:Ljava/lang/String;

    invoke-virtual {p1}, Lchat/ola/vn/entity/ad;->h()Ljava/lang/String;

    move-result-object v0

    iput-object v0, p0, Lchat/ola/vn/entity/t;->h:Ljava/lang/String;

    invoke-virtual {p1}, Lchat/ola/vn/entity/ad;->x()Ljava/lang/String;

    move-result-object v0

    iput-object v0, p0, Lchat/ola/vn/entity/t;->j:Ljava/lang/String;

    invoke-virtual {p1}, Lchat/ola/vn/entity/ad;->w()Ljava/lang/String;

    move-result-object v0

    iput-object v0, p0, Lchat/ola/vn/entity/t;->i:Ljava/lang/String;

    invoke-virtual {p1}, Lchat/ola/vn/entity/ad;->m()S

    move-result v0

    iput-short v0, p0, Lchat/ola/vn/entity/t;->r:S

    invoke-virtual {p1}, Lchat/ola/vn/entity/ad;->y()J

    move-result-wide v0

    iput-wide v0, p0, Lchat/ola/vn/entity/t;->l:J

    invoke-virtual {p1}, Lchat/ola/vn/entity/ad;->z()I

    move-result v0

    iput v0, p0, Lchat/ola/vn/entity/t;->p:I

    invoke-virtual {p1}, Lchat/ola/vn/entity/ad;->A()J

    move-result-wide v0

    iput-wide v0, p0, Lchat/ola/vn/entity/t;->m:J

    invoke-virtual {p1}, Lchat/ola/vn/entity/ad;->B()Ljava/util/List;

    move-result-object v0

    iput-object v0, p0, Lchat/ola/vn/entity/t;->a:Ljava/util/List;

    iget-object v0, p1, Lchat/ola/vn/entity/ad;->b:Ljava/lang/String;

    iput-object v0, p0, Lchat/ola/vn/entity/t;->b:Ljava/lang/String;

    iget v0, p1, Lchat/ola/vn/entity/ad;->s:I

    iput v0, p0, Lchat/ola/vn/entity/t;->s:I

    iget v0, p1, Lchat/ola/vn/entity/ad;->t:I

    iput v0, p0, Lchat/ola/vn/entity/t;->t:I

    instance-of v0, p1, Lchat/ola/vn/entity/t;

    if-eqz v0, :cond_0

    check-cast p1, Lchat/ola/vn/entity/t;

    iget-object p1, p1, Lchat/ola/vn/entity/t;->w:Ljava/util/List;

    iput-object p1, p0, Lchat/ola/vn/entity/t;->w:Ljava/util/List;

    :cond_0
    return-void
.end method

.method public a(Ljava/lang/String;)V
    .locals 0

    iput-object p1, p0, Lchat/ola/vn/entity/t;->y:Ljava/lang/String;

    return-void
.end method

.method public a(Ljava/util/List;)V
    .locals 0
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "(",
            "Ljava/util/List<",
            "Lchat/ola/vn/entity/t;",
            ">;)V"
        }
    .end annotation

    iput-object p1, p0, Lchat/ola/vn/entity/t;->v:Ljava/util/List;

    return-void
.end method

.method public a(Z)V
    .locals 0

    iput-boolean p1, p0, Lchat/ola/vn/entity/t;->u:Z

    return-void
.end method

.method public a(JLjava/util/List;)Z
    .locals 3
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "(J",
            "Ljava/util/List<",
            "Lchat/ola/vn/entity/g;",
            ">;)Z"
        }
    .end annotation

    invoke-virtual {p0}, Lchat/ola/vn/entity/t;->r()J

    move-result-wide v0

    cmp-long v2, v0, p1

    if-nez v2, :cond_2

    invoke-static {p3}, Lchat/ola/vn/r/a/e;->b(Ljava/util/List;)Ljava/util/List;

    move-result-object p1

    if-eqz p1, :cond_1

    iget-object p2, p0, Lchat/ola/vn/entity/t;->x:Ljava/util/List;

    if-nez p2, :cond_0

    iput-object p1, p0, Lchat/ola/vn/entity/t;->x:Ljava/util/List;

    goto :goto_0

    :cond_0
    iget-object p2, p0, Lchat/ola/vn/entity/t;->x:Ljava/util/List;

    invoke-interface {p2, p1}, Ljava/util/List;->addAll(Ljava/util/Collection;)Z

    :cond_1
    :goto_0
    const/4 p1, 0x1

    return p1

    :cond_2
    const/4 p1, 0x0

    return p1
.end method

.method public a(Lchat/ola/vn/entity/g;Ljava/util/List;)Z
    .locals 4
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "(",
            "Lchat/ola/vn/entity/g;",
            "Ljava/util/List<",
            "Lchat/ola/vn/entity/g;",
            ">;)Z"
        }
    .end annotation

    invoke-virtual {p0}, Lchat/ola/vn/entity/t;->r()J

    move-result-wide v0

    invoke-virtual {p1}, Lchat/ola/vn/entity/g;->e()J

    move-result-wide v2

    cmp-long p1, v0, v2

    if-nez p1, :cond_0

    invoke-static {p2}, Lchat/ola/vn/r/a/e;->b(Ljava/util/List;)Ljava/util/List;

    move-result-object p1

    iput-object p1, p0, Lchat/ola/vn/entity/t;->x:Ljava/util/List;

    const/4 p1, 0x1

    return p1

    :cond_0
    const/4 p1, 0x0

    return p1
.end method

.method public b(J)V
    .locals 0

    iput-wide p1, p0, Lchat/ola/vn/entity/t;->z:J

    return-void
.end method

.method public b(Landroid/widget/ListView;)V
    .locals 3

    :try_start_0
    iget v0, p0, Lchat/ola/vn/entity/t;->s:I

    const-wide/16 v1, 0xfa

    if-eqz v0, :cond_0

    iget v0, p0, Lchat/ola/vn/entity/t;->t:I

    if-eqz v0, :cond_0

    new-instance v0, Lchat/ola/vn/entity/t$1;

    invoke-direct {v0, p0, p1}, Lchat/ola/vn/entity/t$1;-><init>(Lchat/ola/vn/entity/t;Landroid/widget/ListView;)V

    :goto_0
    invoke-virtual {p1, v0, v1, v2}, Landroid/widget/ListView;->postDelayed(Ljava/lang/Runnable;J)Z

    return-void

    :cond_0
    new-instance v0, Lchat/ola/vn/entity/t$2;

    invoke-direct {v0, p0, p1}, Lchat/ola/vn/entity/t$2;-><init>(Lchat/ola/vn/entity/t;Landroid/widget/ListView;)V
    :try_end_0
    .catch Ljava/lang/Throwable; {:try_start_0 .. :try_end_0} :catch_0

    goto :goto_0

    :catch_0
    return-void
.end method

.method public b(Ljava/lang/String;)V
    .locals 0

    iput-object p1, p0, Lchat/ola/vn/entity/t;->B:Ljava/lang/String;

    return-void
.end method

.method public b(Ljava/util/List;)V
    .locals 1
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "(",
            "Ljava/util/List<",
            "Lchat/ola/vn/entity/t;",
            ">;)V"
        }
    .end annotation

    if-eqz p1, :cond_1

    iget-object v0, p0, Lchat/ola/vn/entity/t;->v:Ljava/util/List;

    if-eqz v0, :cond_0

    iget-object v0, p0, Lchat/ola/vn/entity/t;->v:Ljava/util/List;

    invoke-interface {v0, p1}, Ljava/util/List;->addAll(Ljava/util/Collection;)Z

    return-void

    :cond_0
    new-instance v0, Ljava/util/ArrayList;

    invoke-direct {v0, p1}, Ljava/util/ArrayList;-><init>(Ljava/util/Collection;)V

    iput-object v0, p0, Lchat/ola/vn/entity/t;->v:Ljava/util/List;

    :cond_1
    return-void
.end method

.method public b(Z)V
    .locals 0

    iput-boolean p1, p0, Lchat/ola/vn/entity/t;->A:Z

    return-void
.end method

.method public b()Z
    .locals 1

    iget-boolean v0, p0, Lchat/ola/vn/entity/t;->u:Z

    return v0
.end method

.method public b(Lchat/ola/vn/entity/g;Ljava/util/List;)Z
    .locals 2
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "(",
            "Lchat/ola/vn/entity/g;",
            "Ljava/util/List<",
            "Lchat/ola/vn/entity/g;",
            ">;)Z"
        }
    .end annotation

    invoke-virtual {p1}, Lchat/ola/vn/entity/g;->e()J

    move-result-wide v0

    invoke-virtual {p0, v0, v1, p2}, Lchat/ola/vn/entity/t;->a(JLjava/util/List;)Z

    move-result p1

    return p1
.end method

.method public c()V
    .locals 1

    :try_start_0
    iget-object v0, p0, Lchat/ola/vn/entity/t;->x:Ljava/util/List;

    invoke-interface {v0}, Ljava/util/List;->clear()V
    :try_end_0
    .catch Ljava/lang/Throwable; {:try_start_0 .. :try_end_0} :catch_0

    :catch_0
    return-void
.end method

.method public d()Ljava/util/List;
    .locals 1
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "()",
            "Ljava/util/List<",
            "Lchat/ola/vn/entry/b;",
            ">;"
        }
    .end annotation

    iget-object v0, p0, Lchat/ola/vn/entity/t;->x:Ljava/util/List;

    return-object v0
.end method

.method public e()Ljava/util/List;
    .locals 1
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "()",
            "Ljava/util/List<",
            "Lchat/ola/vn/entry/c;",
            ">;"
        }
    .end annotation

    iget-object v0, p0, Lchat/ola/vn/entity/t;->w:Ljava/util/List;

    if-nez v0, :cond_0

    invoke-virtual {p0}, Lchat/ola/vn/entity/t;->f()V

    :cond_0
    iget-object v0, p0, Lchat/ola/vn/entity/t;->w:Ljava/util/List;

    return-object v0
.end method

.method public f()V
    .locals 10

    iget-object v0, p0, Lchat/ola/vn/entity/t;->e:[Ljava/lang/String;

    const/4 v1, 0x0

    if-eqz v0, :cond_a

    iget-object v0, p0, Lchat/ola/vn/entity/t;->e:[Ljava/lang/String;

    array-length v0, v0

    if-lez v0, :cond_a

    new-instance v0, Ljava/util/ArrayList;

    invoke-direct {v0}, Ljava/util/ArrayList;-><init>()V

    iget-object v2, p0, Lchat/ola/vn/entity/t;->e:[Ljava/lang/String;

    array-length v2, v2

    const/4 v3, 0x0

    const/4 v4, 0x0

    :goto_0
    if-ge v4, v2, :cond_5

    iget-object v5, p0, Lchat/ola/vn/entity/t;->e:[Ljava/lang/String;

    aget-object v5, v5, v4

    if-nez v4, :cond_0

    goto/16 :goto_4

    :cond_0
    if-eqz v5, :cond_4

    invoke-virtual {v5}, Ljava/lang/String;->trim()Ljava/lang/String;

    move-result-object v6

    invoke-virtual {v6}, Ljava/lang/String;->length()I

    move-result v6

    if-eqz v6, :cond_4

    invoke-virtual {v5}, Ljava/lang/String;->toLowerCase()Ljava/lang/String;

    move-result-object v6

    invoke-static {v5}, Lchat/ola/vn/util/i;->b(Ljava/lang/CharSequence;)Ljava/util/ArrayList;

    move-result-object v7

    if-eqz v7, :cond_1

    invoke-virtual {v7}, Ljava/util/ArrayList;->isEmpty()Z

    move-result v8

    if-nez v8, :cond_1

    invoke-virtual {v7}, Ljava/util/ArrayList;->size()I

    move-result v5

    const/4 v6, 0x0

    :goto_1
    if-ge v6, v5, :cond_4

    new-instance v8, Lchat/ola/vn/entry/c;

    invoke-virtual {v7, v6}, Ljava/util/ArrayList;->get(I)Ljava/lang/Object;

    move-result-object v9

    check-cast v9, Ljava/lang/CharSequence;

    invoke-direct {v8, v3, v9}, Lchat/ola/vn/entry/c;-><init>(SLjava/lang/CharSequence;)V

    invoke-interface {v0, v8}, Ljava/util/List;->add(Ljava/lang/Object;)Z

    add-int/lit8 v6, v6, 0x1

    goto :goto_1

    :cond_1
    const-string v7, "youtu"

    invoke-virtual {v6, v7}, Ljava/lang/String;->indexOf(Ljava/lang/String;)I

    move-result v7

    if-ltz v7, :cond_2

    invoke-static {v5, v3}, Lchat/ola/vn/util/i;->a(Ljava/lang/CharSequence;Z)Ljava/util/List;

    move-result-object v7

    if-eqz v7, :cond_2

    invoke-interface {v7}, Ljava/util/List;->isEmpty()Z

    move-result v8

    if-nez v8, :cond_2

    invoke-interface {v7}, Ljava/util/List;->iterator()Ljava/util/Iterator;

    move-result-object v5

    :goto_2
    invoke-interface {v5}, Ljava/util/Iterator;->hasNext()Z

    move-result v6

    if-eqz v6, :cond_4

    invoke-interface {v5}, Ljava/util/Iterator;->next()Ljava/lang/Object;

    move-result-object v6

    check-cast v6, Ljava/lang/String;

    new-instance v7, Lchat/ola/vn/entry/c;

    const/4 v8, 0x1

    invoke-direct {v7, v8, v6}, Lchat/ola/vn/entry/c;-><init>(SLjava/lang/CharSequence;)V

    invoke-interface {v0, v7}, Ljava/util/List;->add(Ljava/lang/Object;)Z

    goto :goto_2

    :cond_2
    const-string v7, "mall.ola.vn"

    invoke-virtual {v6, v7}, Ljava/lang/String;->indexOf(Ljava/lang/String;)I

    move-result v6

    if-ltz v6, :cond_3

    invoke-static {v5, v3}, Lchat/ola/vn/util/i;->b(Ljava/lang/CharSequence;Z)Ljava/util/List;

    move-result-object v6

    if-eqz v6, :cond_3

    invoke-interface {v6}, Ljava/util/List;->isEmpty()Z

    move-result v7

    if-nez v7, :cond_3

    invoke-interface {v6}, Ljava/util/List;->iterator()Ljava/util/Iterator;

    move-result-object v5

    :goto_3
    invoke-interface {v5}, Ljava/util/Iterator;->hasNext()Z

    move-result v6

    if-eqz v6, :cond_4

    invoke-interface {v5}, Ljava/util/Iterator;->next()Ljava/lang/Object;

    move-result-object v6

    check-cast v6, Ljava/lang/String;

    new-instance v7, Lchat/ola/vn/entry/c;

    const/4 v8, 0x2

    invoke-direct {v7, v8, v6}, Lchat/ola/vn/entry/c;-><init>(SLjava/lang/CharSequence;)V

    invoke-interface {v0, v7}, Ljava/util/List;->add(Ljava/lang/Object;)Z

    goto :goto_3

    :cond_3
    invoke-static {v5}, Lchat/ola/vn/util/i;->c(Ljava/lang/String;)Ljava/lang/CharSequence;

    move-result-object v5

    new-instance v6, Lchat/ola/vn/entry/c;

    const/4 v7, 0x3

    invoke-direct {v6, v7, v5}, Lchat/ola/vn/entry/c;-><init>(SLjava/lang/CharSequence;)V

    invoke-interface {v0, v6}, Ljava/util/List;->add(Ljava/lang/Object;)Z

    :cond_4
    :goto_4
    add-int/lit8 v4, v4, 0x1

    goto/16 :goto_0

    :cond_5
    new-instance v2, Lchat/ola/vn/entry/c;

    const/4 v3, 0x4

    invoke-direct {v2, v3, v1}, Lchat/ola/vn/entry/c;-><init>(SLjava/lang/CharSequence;)V

    invoke-virtual {v2, p0}, Lchat/ola/vn/entry/c;->a(Lchat/ola/vn/entity/t;)Lchat/ola/vn/entry/c;

    move-result-object v2

    invoke-virtual {p0}, Lchat/ola/vn/entity/t;->t()I

    move-result v3

    invoke-virtual {v2, v3}, Lchat/ola/vn/entry/c;->a(I)V

    invoke-virtual {p0}, Lchat/ola/vn/entity/t;->s()I

    move-result v3

    invoke-virtual {v2, v3}, Lchat/ola/vn/entry/c;->b(I)V

    invoke-interface {v0, v2}, Ljava/util/List;->add(Ljava/lang/Object;)Z

    sget-object v2, Lchat/ola/vn/h;->v:Lchat/ola/vn/r/a/c;

    invoke-virtual {v2}, Lchat/ola/vn/r/a/c;->m()Ljava/util/List;

    move-result-object v2

    const/4 v3, 0x5

    if-eqz v2, :cond_7

    invoke-interface {v2}, Ljava/util/List;->size()I

    move-result v4

    if-lez v4, :cond_7

    invoke-static {}, Ljava/lang/System;->currentTimeMillis()J

    move-result-wide v4

    const-wide/16 v6, 0x2

    rem-long/2addr v4, v6

    const-wide/16 v6, 0x0

    cmp-long v8, v4, v6

    if-nez v8, :cond_7

    new-instance v4, Ljava/util/Random;

    invoke-static {}, Ljava/lang/System;->nanoTime()J

    move-result-wide v5

    invoke-direct {v4, v5, v6}, Ljava/util/Random;-><init>(J)V

    invoke-interface {v2}, Ljava/util/List;->size()I

    move-result v5

    invoke-virtual {v4, v5}, Ljava/util/Random;->nextInt(I)I

    move-result v4

    invoke-interface {v2, v4}, Ljava/util/List;->get(I)Ljava/lang/Object;

    move-result-object v5

    check-cast v5, Lchat/ola/vn/entity/k;

    invoke-static {}, Lchat/ola/vn/OlaApplication;->a()Landroid/content/Context;

    move-result-object v6

    iget-object v7, v5, Lchat/ola/vn/entity/k;->m:Ljava/lang/String;

    invoke-static {v6, v7}, Lchat/ola/vn/util/b;->k(Landroid/content/Context;Ljava/lang/String;)Z

    move-result v6

    if-eqz v6, :cond_6

    invoke-interface {v2, v4}, Ljava/util/List;->remove(I)Ljava/lang/Object;

    sget-boolean v2, Lchat/ola/vn/util/a;->c:Z

    if-eqz v2, :cond_8

    new-instance v2, Lchat/ola/vn/entry/c;

    invoke-direct {v2, v3, v1}, Lchat/ola/vn/entry/c;-><init>(SLjava/lang/CharSequence;)V

    goto :goto_5

    :cond_6
    new-instance v2, Lchat/ola/vn/entry/c;

    invoke-direct {v2, v3, v1}, Lchat/ola/vn/entry/c;-><init>(SLjava/lang/CharSequence;)V

    iput-object v5, v2, Lchat/ola/vn/entry/c;->a:Lchat/ola/vn/entity/k;

    goto :goto_5

    :cond_7
    sget-boolean v2, Lchat/ola/vn/util/a;->c:Z

    if-eqz v2, :cond_8

    new-instance v2, Lchat/ola/vn/entry/c;

    invoke-direct {v2, v3, v1}, Lchat/ola/vn/entry/c;-><init>(SLjava/lang/CharSequence;)V

    :goto_5
    invoke-interface {v0, v2}, Ljava/util/List;->add(Ljava/lang/Object;)Z

    :cond_8
    iget-object v1, p0, Lchat/ola/vn/entity/t;->a:Ljava/util/List;

    if-eqz v1, :cond_9

    new-instance v1, Lchat/ola/vn/entry/d;

    invoke-direct {v1}, Lchat/ola/vn/entry/d;-><init>()V

    iget-object v2, p0, Lchat/ola/vn/entity/t;->a:Ljava/util/List;

    iput-object v2, v1, Lchat/ola/vn/entry/d;->b:Ljava/util/List;

    iget-object v2, p0, Lchat/ola/vn/entity/t;->b:Ljava/lang/String;

    iput-object v2, v1, Lchat/ola/vn/entry/d;->c:Ljava/lang/String;

    invoke-interface {v0, v1}, Ljava/util/List;->add(Ljava/lang/Object;)Z

    :cond_9
    iput-object v0, p0, Lchat/ola/vn/entity/t;->w:Ljava/util/List;

    return-void

    :cond_a
    iput-object v1, p0, Lchat/ola/vn/entity/t;->w:Ljava/util/List;

    return-void
.end method

.method public g()Ljava/util/ArrayList;
    .locals 6
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "()",
            "Ljava/util/ArrayList<",
            "Ljava/lang/String;",
            ">;"
        }
    .end annotation

    :try_start_0
    new-instance v0, Ljava/util/ArrayList;

    invoke-direct {v0}, Ljava/util/ArrayList;-><init>()V

    iget-object v1, p0, Lchat/ola/vn/entity/t;->e:[Ljava/lang/String;

    array-length v2, v1

    const/4 v3, 0x0

    :goto_0
    if-ge v3, v2, :cond_1

    aget-object v4, v1, v3

    invoke-static {v4}, Lchat/ola/vn/util/i;->b(Ljava/lang/CharSequence;)Ljava/util/ArrayList;

    move-result-object v4

    if-eqz v4, :cond_0

    invoke-virtual {v4}, Ljava/util/ArrayList;->isEmpty()Z

    move-result v5

    if-nez v5, :cond_0

    invoke-virtual {v0, v4}, Ljava/util/ArrayList;->addAll(Ljava/util/Collection;)Z
    :try_end_0
    .catch Ljava/lang/Throwable; {:try_start_0 .. :try_end_0} :catch_0

    :cond_0
    add-int/lit8 v3, v3, 0x1

    goto :goto_0

    :cond_1
    return-object v0

    :catch_0
    const/4 v0, 0x0

    return-object v0
.end method

.method public h()Ljava/lang/String;
    .locals 7

    iget-object v0, p0, Lchat/ola/vn/entity/t;->h:Ljava/lang/String;

    if-eqz v0, :cond_0

    iget-object v0, p0, Lchat/ola/vn/entity/t;->h:Ljava/lang/String;

    return-object v0

    :cond_0
    const/4 v0, 0x0

    :try_start_0
    iget-object v1, p0, Lchat/ola/vn/entity/t;->e:[Ljava/lang/String;

    array-length v2, v1

    const/4 v3, 0x0

    const/4 v4, 0x0

    :goto_0
    if-ge v4, v2, :cond_2

    aget-object v5, v1, v4

    invoke-static {v5}, Lchat/ola/vn/util/i;->b(Ljava/lang/CharSequence;)Ljava/util/ArrayList;

    move-result-object v5

    if-eqz v5, :cond_1

    invoke-virtual {v5}, Ljava/util/ArrayList;->isEmpty()Z

    move-result v6

    if-nez v6, :cond_1

    invoke-virtual {v5, v3}, Ljava/util/ArrayList;->get(I)Ljava/lang/Object;

    move-result-object v1

    check-cast v1, Ljava/lang/String;

    iput-object v1, p0, Lchat/ola/vn/entity/t;->h:Ljava/lang/String;

    iget-object v1, p0, Lchat/ola/vn/entity/t;->h:Ljava/lang/String;
    :try_end_0
    .catch Ljava/lang/Throwable; {:try_start_0 .. :try_end_0} :catch_0

    return-object v1

    :cond_1
    add-int/lit8 v4, v4, 0x1

    goto :goto_0

    :catch_0
    :cond_2
    return-object v0
.end method

.method public i()I
    .locals 1

    iget-object v0, p0, Lchat/ola/vn/entity/t;->v:Ljava/util/List;

    if-nez v0, :cond_0

    const/4 v0, 0x0

    return v0

    :cond_0
    iget-object v0, p0, Lchat/ola/vn/entity/t;->v:Ljava/util/List;

    invoke-interface {v0}, Ljava/util/List;->size()I

    move-result v0

    return v0
.end method

.method public j()Ljava/lang/String;
    .locals 1

    iget-object v0, p0, Lchat/ola/vn/entity/t;->y:Ljava/lang/String;

    return-object v0
.end method

.method public k()Z
    .locals 1

    iget-boolean v0, p0, Lchat/ola/vn/entity/t;->A:Z

    return v0
.end method

.method public l()Ljava/lang/String;
    .locals 1

    iget-object v0, p0, Lchat/ola/vn/entity/t;->B:Ljava/lang/String;

    invoke-static {v0}, Lchat/ola/vn/util/m;->a(Ljava/lang/String;)Z

    move-result v0

    if-nez v0, :cond_0

    iget-object v0, p0, Lchat/ola/vn/entity/t;->B:Ljava/lang/String;

    return-object v0

    :cond_0
    iget-object v0, p0, Lchat/ola/vn/entity/t;->c:Ljava/lang/String;

    return-object v0
.end method
