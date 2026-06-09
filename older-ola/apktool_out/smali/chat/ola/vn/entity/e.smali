.class public Lchat/ola/vn/entity/e;
.super Ljava/lang/Object;


# instance fields
.field private A:I

.field private B:Lchat/ola/vn/entity/e;

.field private C:J

.field private D:I

.field private E:Ljava/util/List;
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "Ljava/util/List<",
            "Ljava/lang/String;",
            ">;"
        }
    .end annotation
.end field

.field private F:Z

.field private G:I

.field private H:I

.field private I:S

.field private J:Ljava/lang/String;

.field private K:Ljava/util/List;
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "Ljava/util/List<",
            "Lchat/ola/vn/entity/e;",
            ">;"
        }
    .end annotation
.end field

.field private L:I

.field private M:I

.field private N:Lchat/ola/vn/entity/e;

.field private O:Lchat/ola/vn/entity/e;

.field private P:Ljava/util/List;
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "Ljava/util/List<",
            "Lchat/ola/vn/entity/e;",
            ">;"
        }
    .end annotation
.end field

.field private Q:Ljava/util/List;
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "Ljava/util/List<",
            "Lchat/ola/vn/entity/e;",
            ">;"
        }
    .end annotation
.end field

.field private R:Ljava/lang/String;

.field private S:I

.field private a:J

.field private b:Ljava/lang/String;

.field private c:Ljava/lang/String;

.field private d:Ljava/lang/String;

.field private e:Ljava/lang/String;

.field private f:Ljava/lang/String;

.field private g:Ljava/lang/String;

.field private h:Ljava/lang/String;

.field private i:Ljava/lang/String;

.field private j:Ljava/lang/String;

.field private k:Ljava/lang/String;

.field private l:J

.field private m:I

.field private n:I

.field private o:I

.field private p:J

.field private q:Ljava/util/List;
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "Ljava/util/List<",
            "Lchat/ola/vn/entity/e;",
            ">;"
        }
    .end annotation
.end field

.field private r:Ljava/util/List;
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "Ljava/util/List<",
            "Lchat/ola/vn/entity/e;",
            ">;"
        }
    .end annotation
.end field

.field private s:Ljava/util/List;
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "Ljava/util/List<",
            "Lchat/ola/vn/entity/e;",
            ">;"
        }
    .end annotation
.end field

.field private t:Ljava/util/List;
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "Ljava/util/List<",
            "Lchat/ola/vn/entity/e;",
            ">;"
        }
    .end annotation
.end field

.field private u:Ljava/util/List;
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "Ljava/util/List<",
            "Lchat/ola/vn/entry/b;",
            ">;"
        }
    .end annotation
.end field

.field private v:Z

.field private w:Z

.field private x:Z

.field private y:Z

.field private z:I


# direct methods
.method public constructor <init>()V
    .locals 2

    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    const/4 v0, 0x0

    iput-boolean v0, p0, Lchat/ola/vn/entity/e;->v:Z

    iput-boolean v0, p0, Lchat/ola/vn/entity/e;->w:Z

    const/4 v0, 0x1

    iput-boolean v0, p0, Lchat/ola/vn/entity/e;->x:Z

    iput-boolean v0, p0, Lchat/ola/vn/entity/e;->y:Z

    const-wide/16 v0, 0x0

    iput-wide v0, p0, Lchat/ola/vn/entity/e;->C:J

    return-void
.end method

.method static synthetic i(Lchat/ola/vn/entity/e;)I
    .locals 0

    iget p0, p0, Lchat/ola/vn/entity/e;->z:I

    return p0
.end method

.method static synthetic j(Lchat/ola/vn/entity/e;)I
    .locals 0

    iget p0, p0, Lchat/ola/vn/entity/e;->A:I

    return p0
.end method


# virtual methods
.method public A()Ljava/lang/String;
    .locals 1

    iget-object v0, p0, Lchat/ola/vn/entity/e;->j:Ljava/lang/String;

    return-object v0
.end method

.method public B()J
    .locals 2

    iget-wide v0, p0, Lchat/ola/vn/entity/e;->l:J

    return-wide v0
.end method

.method public C()I
    .locals 1

    iget v0, p0, Lchat/ola/vn/entity/e;->m:I

    return v0
.end method

.method public D()I
    .locals 1

    iget v0, p0, Lchat/ola/vn/entity/e;->n:I

    return v0
.end method

.method public E()I
    .locals 1

    iget v0, p0, Lchat/ola/vn/entity/e;->o:I

    return v0
.end method

.method public F()J
    .locals 2

    iget-wide v0, p0, Lchat/ola/vn/entity/e;->p:J

    return-wide v0
.end method

.method public G()S
    .locals 1

    iget-short v0, p0, Lchat/ola/vn/entity/e;->I:S

    return v0
.end method

.method public H()J
    .locals 4

    const-wide/16 v0, 0x0

    :try_start_0
    iget-object v2, p0, Lchat/ola/vn/entity/e;->u:Ljava/util/List;

    if-eqz v2, :cond_1

    iget-object v2, p0, Lchat/ola/vn/entity/e;->u:Ljava/util/List;

    invoke-interface {v2}, Ljava/util/List;->isEmpty()Z

    move-result v2

    if-eqz v2, :cond_0

    return-wide v0

    :cond_0
    iget-object v2, p0, Lchat/ola/vn/entity/e;->u:Ljava/util/List;

    iget-object v3, p0, Lchat/ola/vn/entity/e;->u:Ljava/util/List;

    invoke-interface {v3}, Ljava/util/List;->size()I

    move-result v3

    add-int/lit8 v3, v3, -0x1

    invoke-interface {v2, v3}, Ljava/util/List;->get(I)Ljava/lang/Object;

    move-result-object v2

    check-cast v2, Lchat/ola/vn/entry/b;

    iget-object v2, v2, Lchat/ola/vn/entry/b;->b:Lchat/ola/vn/entity/g;

    invoke-virtual {v2}, Lchat/ola/vn/entity/g;->e()J

    move-result-wide v2
    :try_end_0
    .catch Ljava/lang/Throwable; {:try_start_0 .. :try_end_0} :catch_0

    return-wide v2

    :catch_0
    :cond_1
    return-wide v0
.end method

.method public I()V
    .locals 1

    const/4 v0, -0x1

    iput v0, p0, Lchat/ola/vn/entity/e;->z:I

    iput v0, p0, Lchat/ola/vn/entity/e;->A:I

    return-void
.end method

.method public J()Ljava/lang/String;
    .locals 1

    iget-object v0, p0, Lchat/ola/vn/entity/e;->J:Ljava/lang/String;

    return-object v0
.end method

.method public K()Ljava/util/List;
    .locals 1
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "()",
            "Ljava/util/List<",
            "Lchat/ola/vn/entity/e;",
            ">;"
        }
    .end annotation

    iget-object v0, p0, Lchat/ola/vn/entity/e;->K:Ljava/util/List;

    return-object v0
.end method

.method public L()I
    .locals 1

    iget v0, p0, Lchat/ola/vn/entity/e;->L:I

    return v0
.end method

.method public M()I
    .locals 1

    iget v0, p0, Lchat/ola/vn/entity/e;->M:I

    return v0
.end method

.method public N()Lchat/ola/vn/entity/e;
    .locals 1

    iget-object v0, p0, Lchat/ola/vn/entity/e;->N:Lchat/ola/vn/entity/e;

    return-object v0
.end method

.method public O()Lchat/ola/vn/entity/e;
    .locals 1

    iget-object v0, p0, Lchat/ola/vn/entity/e;->O:Lchat/ola/vn/entity/e;

    return-object v0
.end method

.method public P()Ljava/util/List;
    .locals 1
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "()",
            "Ljava/util/List<",
            "Lchat/ola/vn/entity/e;",
            ">;"
        }
    .end annotation

    iget-object v0, p0, Lchat/ola/vn/entity/e;->Q:Ljava/util/List;

    return-object v0
.end method

.method public Q()Ljava/lang/String;
    .locals 1

    iget-object v0, p0, Lchat/ola/vn/entity/e;->R:Ljava/lang/String;

    return-object v0
.end method

.method public R()I
    .locals 1

    iget v0, p0, Lchat/ola/vn/entity/e;->S:I

    return v0
.end method

.method public a(II)Ljava/lang/String;
    .locals 1

    iget-object p2, p0, Lchat/ola/vn/entity/e;->e:Ljava/lang/String;

    invoke-static {p2}, Lchat/ola/vn/util/m;->a(Ljava/lang/String;)Z

    move-result p2

    if-nez p2, :cond_1

    const/16 p2, 0x190

    if-le p1, p2, :cond_0

    iget-object p1, p0, Lchat/ola/vn/entity/e;->e:Ljava/lang/String;

    return-object p1

    :cond_0
    iget-object p2, p0, Lchat/ola/vn/entity/e;->e:Ljava/lang/String;

    goto :goto_0

    :cond_1
    const/4 p2, 0x0

    :goto_0
    iget-object v0, p0, Lchat/ola/vn/entity/e;->f:Ljava/lang/String;

    invoke-static {v0}, Lchat/ola/vn/util/m;->a(Ljava/lang/String;)Z

    move-result v0

    if-nez v0, :cond_4

    const/16 p2, 0x12c

    if-gt p1, p2, :cond_3

    sget-boolean p1, Lchat/ola/vn/h;->I:Z

    if-eqz p1, :cond_2

    goto :goto_1

    :cond_2
    iget-object p2, p0, Lchat/ola/vn/entity/e;->f:Ljava/lang/String;

    goto :goto_2

    :cond_3
    :goto_1
    iget-object p1, p0, Lchat/ola/vn/entity/e;->f:Ljava/lang/String;

    return-object p1

    :cond_4
    :goto_2
    iget-object p1, p0, Lchat/ola/vn/entity/e;->g:Ljava/lang/String;

    invoke-static {p1}, Lchat/ola/vn/util/m;->a(Ljava/lang/String;)Z

    move-result p1

    if-nez p1, :cond_5

    iget-object p1, p0, Lchat/ola/vn/entity/e;->g:Ljava/lang/String;

    return-object p1

    :cond_5
    if-nez p2, :cond_6

    iget-object p1, p0, Lchat/ola/vn/entity/e;->h:Ljava/lang/String;

    return-object p1

    :cond_6
    return-object p2
.end method

.method public a(I)V
    .locals 0

    iput p1, p0, Lchat/ola/vn/entity/e;->G:I

    return-void
.end method

.method public a(J)V
    .locals 0

    iput-wide p1, p0, Lchat/ola/vn/entity/e;->a:J

    return-void
.end method

.method public a(Landroid/widget/ListView;)V
    .locals 1

    :try_start_0
    invoke-virtual {p1}, Landroid/widget/ListView;->getFirstVisiblePosition()I

    move-result v0

    iput v0, p0, Lchat/ola/vn/entity/e;->z:I

    iget v0, p0, Lchat/ola/vn/entity/e;->z:I

    invoke-virtual {p1, v0}, Landroid/widget/ListView;->getChildAt(I)Landroid/view/View;

    move-result-object p1

    if-eqz p1, :cond_0

    invoke-virtual {p1}, Landroid/view/View;->getTop()I

    move-result p1

    :goto_0
    iput p1, p0, Lchat/ola/vn/entity/e;->A:I
    :try_end_0
    .catch Ljava/lang/Throwable; {:try_start_0 .. :try_end_0} :catch_0

    return-void

    :cond_0
    const/4 p1, 0x0

    goto :goto_0

    :catch_0
    return-void
.end method

.method public a(Lchat/ola/vn/entity/e;)V
    .locals 5

    iget-object v0, p1, Lchat/ola/vn/entity/e;->b:Ljava/lang/String;

    iput-object v0, p0, Lchat/ola/vn/entity/e;->b:Ljava/lang/String;

    iget-object v0, p1, Lchat/ola/vn/entity/e;->c:Ljava/lang/String;

    iput-object v0, p0, Lchat/ola/vn/entity/e;->c:Ljava/lang/String;

    iget-object v0, p1, Lchat/ola/vn/entity/e;->d:Ljava/lang/String;

    iput-object v0, p0, Lchat/ola/vn/entity/e;->d:Ljava/lang/String;

    iget-object v0, p1, Lchat/ola/vn/entity/e;->e:Ljava/lang/String;

    invoke-static {v0}, Lchat/ola/vn/util/m;->a(Ljava/lang/String;)Z

    move-result v0

    if-nez v0, :cond_0

    iget-object v0, p1, Lchat/ola/vn/entity/e;->e:Ljava/lang/String;

    iput-object v0, p0, Lchat/ola/vn/entity/e;->e:Ljava/lang/String;

    :cond_0
    iget-object v0, p1, Lchat/ola/vn/entity/e;->f:Ljava/lang/String;

    invoke-static {v0}, Lchat/ola/vn/util/m;->a(Ljava/lang/String;)Z

    move-result v0

    if-nez v0, :cond_1

    iget-object v0, p1, Lchat/ola/vn/entity/e;->f:Ljava/lang/String;

    iput-object v0, p0, Lchat/ola/vn/entity/e;->f:Ljava/lang/String;

    :cond_1
    iget-object v0, p1, Lchat/ola/vn/entity/e;->g:Ljava/lang/String;

    invoke-static {v0}, Lchat/ola/vn/util/m;->a(Ljava/lang/String;)Z

    move-result v0

    if-nez v0, :cond_2

    iget-object v0, p1, Lchat/ola/vn/entity/e;->g:Ljava/lang/String;

    iput-object v0, p0, Lchat/ola/vn/entity/e;->g:Ljava/lang/String;

    :cond_2
    iget-object v0, p1, Lchat/ola/vn/entity/e;->h:Ljava/lang/String;

    invoke-static {v0}, Lchat/ola/vn/util/m;->a(Ljava/lang/String;)Z

    move-result v0

    if-nez v0, :cond_3

    iget-object v0, p1, Lchat/ola/vn/entity/e;->h:Ljava/lang/String;

    iput-object v0, p0, Lchat/ola/vn/entity/e;->h:Ljava/lang/String;

    :cond_3
    iget-object v0, p1, Lchat/ola/vn/entity/e;->k:Ljava/lang/String;

    invoke-static {v0}, Lchat/ola/vn/util/m;->a(Ljava/lang/String;)Z

    move-result v0

    if-nez v0, :cond_4

    iget-object v0, p1, Lchat/ola/vn/entity/e;->k:Ljava/lang/String;

    iput-object v0, p0, Lchat/ola/vn/entity/e;->k:Ljava/lang/String;

    :cond_4
    iget-object v0, p1, Lchat/ola/vn/entity/e;->i:Ljava/lang/String;

    invoke-static {v0}, Lchat/ola/vn/util/m;->a(Ljava/lang/String;)Z

    move-result v0

    if-nez v0, :cond_5

    iget-object v0, p1, Lchat/ola/vn/entity/e;->i:Ljava/lang/String;

    iput-object v0, p0, Lchat/ola/vn/entity/e;->i:Ljava/lang/String;

    :cond_5
    iget-object v0, p1, Lchat/ola/vn/entity/e;->j:Ljava/lang/String;

    invoke-static {v0}, Lchat/ola/vn/util/m;->a(Ljava/lang/String;)Z

    move-result v0

    if-nez v0, :cond_6

    iget-object v0, p1, Lchat/ola/vn/entity/e;->j:Ljava/lang/String;

    iput-object v0, p0, Lchat/ola/vn/entity/e;->j:Ljava/lang/String;

    :cond_6
    iget-wide v0, p1, Lchat/ola/vn/entity/e;->l:J

    const-wide/16 v2, 0x0

    cmp-long v4, v0, v2

    if-eqz v4, :cond_7

    iget-wide v0, p1, Lchat/ola/vn/entity/e;->l:J

    iput-wide v0, p0, Lchat/ola/vn/entity/e;->l:J

    :cond_7
    iget v0, p1, Lchat/ola/vn/entity/e;->m:I

    if-eqz v0, :cond_8

    iget v0, p1, Lchat/ola/vn/entity/e;->m:I

    iput v0, p0, Lchat/ola/vn/entity/e;->m:I

    :cond_8
    iget v0, p1, Lchat/ola/vn/entity/e;->n:I

    if-eqz v0, :cond_9

    iget v0, p1, Lchat/ola/vn/entity/e;->n:I

    iput v0, p0, Lchat/ola/vn/entity/e;->n:I

    :cond_9
    iget-wide v0, p1, Lchat/ola/vn/entity/e;->p:J

    cmp-long v4, v0, v2

    if-eqz v4, :cond_a

    iget-wide v0, p1, Lchat/ola/vn/entity/e;->p:J

    iput-wide v0, p0, Lchat/ola/vn/entity/e;->p:J

    :cond_a
    iget-object v0, p1, Lchat/ola/vn/entity/e;->q:Ljava/util/List;

    if-eqz v0, :cond_b

    iget-object v0, p1, Lchat/ola/vn/entity/e;->q:Ljava/util/List;

    iput-object v0, p0, Lchat/ola/vn/entity/e;->q:Ljava/util/List;

    :cond_b
    iget-object v0, p1, Lchat/ola/vn/entity/e;->r:Ljava/util/List;

    if-eqz v0, :cond_c

    iget-object v0, p1, Lchat/ola/vn/entity/e;->r:Ljava/util/List;

    iput-object v0, p0, Lchat/ola/vn/entity/e;->r:Ljava/util/List;

    :cond_c
    iget-object v0, p1, Lchat/ola/vn/entity/e;->t:Ljava/util/List;

    if-eqz v0, :cond_d

    iget-object v0, p1, Lchat/ola/vn/entity/e;->t:Ljava/util/List;

    iput-object v0, p0, Lchat/ola/vn/entity/e;->t:Ljava/util/List;

    :cond_d
    iget-short v0, p1, Lchat/ola/vn/entity/e;->I:S

    if-eqz v0, :cond_e

    iget-short v0, p1, Lchat/ola/vn/entity/e;->I:S

    iput-short v0, p0, Lchat/ola/vn/entity/e;->I:S

    :cond_e
    iget-object v0, p1, Lchat/ola/vn/entity/e;->P:Ljava/util/List;

    if-eqz v0, :cond_f

    iget-object v0, p1, Lchat/ola/vn/entity/e;->P:Ljava/util/List;

    iput-object v0, p0, Lchat/ola/vn/entity/e;->P:Ljava/util/List;

    :cond_f
    iget-object v0, p1, Lchat/ola/vn/entity/e;->u:Ljava/util/List;

    if-eqz v0, :cond_10

    iget-object v0, p1, Lchat/ola/vn/entity/e;->u:Ljava/util/List;

    iput-object v0, p0, Lchat/ola/vn/entity/e;->u:Ljava/util/List;

    :cond_10
    iget-object v0, p1, Lchat/ola/vn/entity/e;->J:Ljava/lang/String;

    if-eqz v0, :cond_11

    iget-object v0, p1, Lchat/ola/vn/entity/e;->J:Ljava/lang/String;

    iput-object v0, p0, Lchat/ola/vn/entity/e;->J:Ljava/lang/String;

    :cond_11
    iget-object v0, p1, Lchat/ola/vn/entity/e;->R:Ljava/lang/String;

    if-eqz v0, :cond_12

    iget-object v0, p1, Lchat/ola/vn/entity/e;->R:Ljava/lang/String;

    iput-object v0, p0, Lchat/ola/vn/entity/e;->R:Ljava/lang/String;

    :cond_12
    iget-object v0, p1, Lchat/ola/vn/entity/e;->E:Ljava/util/List;

    if-eqz v0, :cond_13

    iget-object v0, p1, Lchat/ola/vn/entity/e;->E:Ljava/util/List;

    iput-object v0, p0, Lchat/ola/vn/entity/e;->E:Ljava/util/List;

    :cond_13
    iget-object v0, p1, Lchat/ola/vn/entity/e;->Q:Ljava/util/List;

    if-eqz v0, :cond_14

    iget-object v0, p1, Lchat/ola/vn/entity/e;->Q:Ljava/util/List;

    iput-object v0, p0, Lchat/ola/vn/entity/e;->Q:Ljava/util/List;

    :cond_14
    iget v0, p1, Lchat/ola/vn/entity/e;->n:I

    if-eqz v0, :cond_15

    iget v0, p1, Lchat/ola/vn/entity/e;->n:I

    iput v0, p0, Lchat/ola/vn/entity/e;->n:I

    :cond_15
    iget v0, p1, Lchat/ola/vn/entity/e;->D:I

    if-eqz v0, :cond_16

    iget v0, p1, Lchat/ola/vn/entity/e;->D:I

    iput v0, p0, Lchat/ola/vn/entity/e;->D:I

    :cond_16
    iget-object v0, p1, Lchat/ola/vn/entity/e;->Q:Ljava/util/List;

    if-eqz v0, :cond_17

    iget-object v0, p1, Lchat/ola/vn/entity/e;->Q:Ljava/util/List;

    iput-object v0, p0, Lchat/ola/vn/entity/e;->Q:Ljava/util/List;

    :cond_17
    iget v0, p1, Lchat/ola/vn/entity/e;->H:I

    iput v0, p0, Lchat/ola/vn/entity/e;->H:I

    iget-boolean v0, p1, Lchat/ola/vn/entity/e;->F:Z

    iput-boolean v0, p0, Lchat/ola/vn/entity/e;->F:Z

    iget p1, p1, Lchat/ola/vn/entity/e;->G:I

    iput p1, p0, Lchat/ola/vn/entity/e;->G:I

    return-void
.end method

.method public a(Ljava/lang/String;)V
    .locals 0

    iput-object p1, p0, Lchat/ola/vn/entity/e;->h:Ljava/lang/String;

    return-void
.end method

.method public a(Ljava/util/List;)V
    .locals 0
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "(",
            "Ljava/util/List<",
            "Lchat/ola/vn/entry/b;",
            ">;)V"
        }
    .end annotation

    iput-object p1, p0, Lchat/ola/vn/entity/e;->u:Ljava/util/List;

    return-void
.end method

.method public a(S)V
    .locals 0

    iput-short p1, p0, Lchat/ola/vn/entity/e;->I:S

    return-void
.end method

.method public a(Z)V
    .locals 0

    iput-boolean p1, p0, Lchat/ola/vn/entity/e;->F:Z

    return-void
.end method

.method public a()Z
    .locals 1

    iget-boolean v0, p0, Lchat/ola/vn/entity/e;->F:Z

    return v0
.end method

.method public b()I
    .locals 1

    iget v0, p0, Lchat/ola/vn/entity/e;->G:I

    return v0
.end method

.method public b(I)V
    .locals 0

    iput p1, p0, Lchat/ola/vn/entity/e;->H:I

    return-void
.end method

.method public b(II)V
    .locals 0

    iput p1, p0, Lchat/ola/vn/entity/e;->z:I

    iput p2, p0, Lchat/ola/vn/entity/e;->A:I

    return-void
.end method

.method public b(J)V
    .locals 0

    iput-wide p1, p0, Lchat/ola/vn/entity/e;->l:J

    return-void
.end method

.method public b(Landroid/widget/ListView;)V
    .locals 1

    new-instance v0, Lchat/ola/vn/entity/e$1;

    invoke-direct {v0, p0, p1}, Lchat/ola/vn/entity/e$1;-><init>(Lchat/ola/vn/entity/e;Landroid/widget/ListView;)V

    invoke-virtual {p1, v0}, Landroid/widget/ListView;->post(Ljava/lang/Runnable;)Z

    return-void
.end method

.method public b(Lchat/ola/vn/entity/e;)V
    .locals 2

    iget v0, p1, Lchat/ola/vn/entity/e;->o:I

    iput v0, p0, Lchat/ola/vn/entity/e;->o:I

    iget-boolean v0, p1, Lchat/ola/vn/entity/e;->v:Z

    iput-boolean v0, p0, Lchat/ola/vn/entity/e;->v:Z

    iget-boolean v0, p1, Lchat/ola/vn/entity/e;->w:Z

    iput-boolean v0, p0, Lchat/ola/vn/entity/e;->w:Z

    iget-boolean v0, p1, Lchat/ola/vn/entity/e;->x:Z

    iput-boolean v0, p0, Lchat/ola/vn/entity/e;->x:Z

    iget-boolean v0, p1, Lchat/ola/vn/entity/e;->y:Z

    iput-boolean v0, p0, Lchat/ola/vn/entity/e;->y:Z

    iget-wide v0, p1, Lchat/ola/vn/entity/e;->C:J

    iput-wide v0, p0, Lchat/ola/vn/entity/e;->C:J

    iget-wide v0, p1, Lchat/ola/vn/entity/e;->a:J

    iput-wide v0, p0, Lchat/ola/vn/entity/e;->a:J

    iget-boolean v0, p1, Lchat/ola/vn/entity/e;->F:Z

    iput-boolean v0, p0, Lchat/ola/vn/entity/e;->F:Z

    iget v0, p1, Lchat/ola/vn/entity/e;->G:I

    iput v0, p0, Lchat/ola/vn/entity/e;->G:I

    iget-object v0, p1, Lchat/ola/vn/entity/e;->R:Ljava/lang/String;

    iput-object v0, p0, Lchat/ola/vn/entity/e;->R:Ljava/lang/String;

    invoke-virtual {p0, p1}, Lchat/ola/vn/entity/e;->a(Lchat/ola/vn/entity/e;)V

    return-void
.end method

.method public b(Ljava/lang/String;)V
    .locals 0

    iput-object p1, p0, Lchat/ola/vn/entity/e;->k:Ljava/lang/String;

    return-void
.end method

.method public b(Ljava/util/List;)V
    .locals 1
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "(",
            "Ljava/util/List<",
            "Lchat/ola/vn/entry/b;",
            ">;)V"
        }
    .end annotation

    if-nez p1, :cond_0

    return-void

    :cond_0
    iget-object v0, p0, Lchat/ola/vn/entity/e;->u:Ljava/util/List;

    if-nez v0, :cond_1

    new-instance v0, Ljava/util/ArrayList;

    invoke-direct {v0}, Ljava/util/ArrayList;-><init>()V

    iput-object v0, p0, Lchat/ola/vn/entity/e;->u:Ljava/util/List;

    :cond_1
    iget-object v0, p0, Lchat/ola/vn/entity/e;->u:Ljava/util/List;

    invoke-interface {v0, p1}, Ljava/util/List;->addAll(Ljava/util/Collection;)Z

    return-void
.end method

.method public b(Z)V
    .locals 2

    iput-boolean p1, p0, Lchat/ola/vn/entity/e;->v:Z

    if-eqz p1, :cond_0

    invoke-static {}, Ljava/lang/System;->currentTimeMillis()J

    move-result-wide v0

    iput-wide v0, p0, Lchat/ola/vn/entity/e;->C:J

    :cond_0
    return-void
.end method

.method public c()I
    .locals 1

    iget v0, p0, Lchat/ola/vn/entity/e;->H:I

    return v0
.end method

.method public c(I)V
    .locals 0

    iput p1, p0, Lchat/ola/vn/entity/e;->D:I

    return-void
.end method

.method public c(J)V
    .locals 0

    iput-wide p1, p0, Lchat/ola/vn/entity/e;->p:J

    return-void
.end method

.method public c(Lchat/ola/vn/entity/e;)V
    .locals 0

    iput-object p1, p0, Lchat/ola/vn/entity/e;->B:Lchat/ola/vn/entity/e;

    return-void
.end method

.method public c(Ljava/lang/String;)V
    .locals 0

    iput-object p1, p0, Lchat/ola/vn/entity/e;->e:Ljava/lang/String;

    return-void
.end method

.method public c(Ljava/util/List;)V
    .locals 0
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "(",
            "Ljava/util/List<",
            "Lchat/ola/vn/entity/e;",
            ">;)V"
        }
    .end annotation

    iput-object p1, p0, Lchat/ola/vn/entity/e;->P:Ljava/util/List;

    return-void
.end method

.method public c(Z)V
    .locals 0

    iput-boolean p1, p0, Lchat/ola/vn/entity/e;->x:Z

    return-void
.end method

.method public d()J
    .locals 2

    iget-wide v0, p0, Lchat/ola/vn/entity/e;->a:J

    return-wide v0
.end method

.method public d(I)V
    .locals 0

    iput p1, p0, Lchat/ola/vn/entity/e;->m:I

    return-void
.end method

.method public d(Lchat/ola/vn/entity/e;)V
    .locals 1

    iget-object v0, p0, Lchat/ola/vn/entity/e;->t:Ljava/util/List;

    if-nez v0, :cond_0

    new-instance v0, Ljava/util/ArrayList;

    invoke-direct {v0}, Ljava/util/ArrayList;-><init>()V

    iput-object v0, p0, Lchat/ola/vn/entity/e;->t:Ljava/util/List;

    :cond_0
    iget-object v0, p0, Lchat/ola/vn/entity/e;->t:Ljava/util/List;

    invoke-interface {v0, p1}, Ljava/util/List;->add(Ljava/lang/Object;)Z

    return-void
.end method

.method public d(Ljava/lang/String;)V
    .locals 0

    iput-object p1, p0, Lchat/ola/vn/entity/e;->f:Ljava/lang/String;

    return-void
.end method

.method public d(Ljava/util/List;)V
    .locals 0
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "(",
            "Ljava/util/List<",
            "Ljava/lang/String;",
            ">;)V"
        }
    .end annotation

    iput-object p1, p0, Lchat/ola/vn/entity/e;->E:Ljava/util/List;

    return-void
.end method

.method public d(Z)V
    .locals 0

    iput-boolean p1, p0, Lchat/ola/vn/entity/e;->y:Z

    return-void
.end method

.method public e()Ljava/lang/String;
    .locals 1

    iget-object v0, p0, Lchat/ola/vn/entity/e;->h:Ljava/lang/String;

    return-object v0
.end method

.method public e(I)V
    .locals 0

    iput p1, p0, Lchat/ola/vn/entity/e;->n:I

    return-void
.end method

.method public e(Lchat/ola/vn/entity/e;)V
    .locals 1

    iget-object v0, p0, Lchat/ola/vn/entity/e;->r:Ljava/util/List;

    if-nez v0, :cond_0

    new-instance v0, Ljava/util/ArrayList;

    invoke-direct {v0}, Ljava/util/ArrayList;-><init>()V

    iput-object v0, p0, Lchat/ola/vn/entity/e;->r:Ljava/util/List;

    :cond_0
    iget-object v0, p0, Lchat/ola/vn/entity/e;->r:Ljava/util/List;

    invoke-interface {v0, p1}, Ljava/util/List;->add(Ljava/lang/Object;)Z

    return-void
.end method

.method public e(Ljava/lang/String;)V
    .locals 0

    iput-object p1, p0, Lchat/ola/vn/entity/e;->g:Ljava/lang/String;

    return-void
.end method

.method public e(Ljava/util/List;)V
    .locals 0
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "(",
            "Ljava/util/List<",
            "Lchat/ola/vn/entity/e;",
            ">;)V"
        }
    .end annotation

    iput-object p1, p0, Lchat/ola/vn/entity/e;->t:Ljava/util/List;

    return-void
.end method

.method public e(Z)V
    .locals 0

    iput-boolean p1, p0, Lchat/ola/vn/entity/e;->w:Z

    return-void
.end method

.method public f()Ljava/util/List;
    .locals 1
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "()",
            "Ljava/util/List<",
            "Lchat/ola/vn/entry/b;",
            ">;"
        }
    .end annotation

    iget-object v0, p0, Lchat/ola/vn/entity/e;->u:Ljava/util/List;

    return-object v0
.end method

.method public f(I)V
    .locals 0

    iput p1, p0, Lchat/ola/vn/entity/e;->o:I

    return-void
.end method

.method public f(Lchat/ola/vn/entity/e;)V
    .locals 1

    iget-object v0, p0, Lchat/ola/vn/entity/e;->s:Ljava/util/List;

    if-nez v0, :cond_0

    new-instance v0, Ljava/util/ArrayList;

    invoke-direct {v0}, Ljava/util/ArrayList;-><init>()V

    iput-object v0, p0, Lchat/ola/vn/entity/e;->s:Ljava/util/List;

    :cond_0
    iget-object v0, p0, Lchat/ola/vn/entity/e;->s:Ljava/util/List;

    invoke-interface {v0, p1}, Ljava/util/List;->add(Ljava/lang/Object;)Z

    return-void
.end method

.method public f(Ljava/lang/String;)V
    .locals 0

    iput-object p1, p0, Lchat/ola/vn/entity/e;->b:Ljava/lang/String;

    return-void
.end method

.method public f(Ljava/util/List;)V
    .locals 0
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "(",
            "Ljava/util/List<",
            "Lchat/ola/vn/entity/e;",
            ">;)V"
        }
    .end annotation

    iput-object p1, p0, Lchat/ola/vn/entity/e;->q:Ljava/util/List;

    return-void
.end method

.method public g(I)Lchat/ola/vn/entity/e;
    .locals 1

    iget-object v0, p0, Lchat/ola/vn/entity/e;->q:Ljava/util/List;

    if-nez v0, :cond_0

    const/4 p1, 0x0

    return-object p1

    :cond_0
    iget-object v0, p0, Lchat/ola/vn/entity/e;->q:Ljava/util/List;

    invoke-interface {v0, p1}, Ljava/util/List;->get(I)Ljava/lang/Object;

    move-result-object p1

    check-cast p1, Lchat/ola/vn/entity/e;

    return-object p1
.end method

.method public g()Ljava/util/List;
    .locals 1
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "()",
            "Ljava/util/List<",
            "Lchat/ola/vn/entity/e;",
            ">;"
        }
    .end annotation

    iget-object v0, p0, Lchat/ola/vn/entity/e;->P:Ljava/util/List;

    return-object v0
.end method

.method public g(Lchat/ola/vn/entity/e;)V
    .locals 0

    iput-object p1, p0, Lchat/ola/vn/entity/e;->N:Lchat/ola/vn/entity/e;

    return-void
.end method

.method public g(Ljava/lang/String;)V
    .locals 0

    iput-object p1, p0, Lchat/ola/vn/entity/e;->c:Ljava/lang/String;

    return-void
.end method

.method public g(Ljava/util/List;)V
    .locals 0
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "(",
            "Ljava/util/List<",
            "Lchat/ola/vn/entity/e;",
            ">;)V"
        }
    .end annotation

    iput-object p1, p0, Lchat/ola/vn/entity/e;->r:Ljava/util/List;

    return-void
.end method

.method public h()Ljava/lang/String;
    .locals 1

    iget-object v0, p0, Lchat/ola/vn/entity/e;->k:Ljava/lang/String;

    return-object v0
.end method

.method public h(I)V
    .locals 0

    iput p1, p0, Lchat/ola/vn/entity/e;->L:I

    return-void
.end method

.method public h(Lchat/ola/vn/entity/e;)V
    .locals 0

    iput-object p1, p0, Lchat/ola/vn/entity/e;->O:Lchat/ola/vn/entity/e;

    return-void
.end method

.method public h(Ljava/lang/String;)V
    .locals 0

    iput-object p1, p0, Lchat/ola/vn/entity/e;->d:Ljava/lang/String;

    return-void
.end method

.method public h(Ljava/util/List;)V
    .locals 0
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "(",
            "Ljava/util/List<",
            "Lchat/ola/vn/entity/e;",
            ">;)V"
        }
    .end annotation

    iput-object p1, p0, Lchat/ola/vn/entity/e;->s:Ljava/util/List;

    return-void
.end method

.method public i()I
    .locals 1

    iget v0, p0, Lchat/ola/vn/entity/e;->D:I

    return v0
.end method

.method public i(I)V
    .locals 0

    iput p1, p0, Lchat/ola/vn/entity/e;->M:I

    return-void
.end method

.method public i(Ljava/lang/String;)V
    .locals 0

    iput-object p1, p0, Lchat/ola/vn/entity/e;->j:Ljava/lang/String;

    return-void
.end method

.method public i(Ljava/util/List;)V
    .locals 1
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "(",
            "Ljava/util/List<",
            "Lchat/ola/vn/entity/e;",
            ">;)V"
        }
    .end annotation

    iget-object v0, p0, Lchat/ola/vn/entity/e;->r:Ljava/util/List;

    if-nez v0, :cond_0

    new-instance v0, Ljava/util/ArrayList;

    invoke-direct {v0}, Ljava/util/ArrayList;-><init>()V

    iput-object v0, p0, Lchat/ola/vn/entity/e;->r:Ljava/util/List;

    :cond_0
    iget-object v0, p0, Lchat/ola/vn/entity/e;->r:Ljava/util/List;

    invoke-interface {v0, p1}, Ljava/util/List;->addAll(Ljava/util/Collection;)Z

    return-void
.end method

.method public j()Ljava/util/List;
    .locals 1
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "()",
            "Ljava/util/List<",
            "Ljava/lang/String;",
            ">;"
        }
    .end annotation

    iget-object v0, p0, Lchat/ola/vn/entity/e;->E:Ljava/util/List;

    return-object v0
.end method

.method public j(I)V
    .locals 0

    iput p1, p0, Lchat/ola/vn/entity/e;->S:I

    return-void
.end method

.method public j(Ljava/lang/String;)V
    .locals 0

    iput-object p1, p0, Lchat/ola/vn/entity/e;->J:Ljava/lang/String;

    return-void
.end method

.method public j(Ljava/util/List;)V
    .locals 1
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "(",
            "Ljava/util/List<",
            "Lchat/ola/vn/entity/e;",
            ">;)V"
        }
    .end annotation

    if-nez p1, :cond_0

    return-void

    :cond_0
    iget-object v0, p0, Lchat/ola/vn/entity/e;->K:Ljava/util/List;

    if-nez v0, :cond_1

    new-instance v0, Ljava/util/ArrayList;

    invoke-direct {v0}, Ljava/util/ArrayList;-><init>()V

    iput-object v0, p0, Lchat/ola/vn/entity/e;->K:Ljava/util/List;

    :cond_1
    iget-object v0, p0, Lchat/ola/vn/entity/e;->K:Ljava/util/List;

    invoke-interface {v0, p1}, Ljava/util/List;->addAll(Ljava/util/Collection;)Z

    return-void
.end method

.method public k(Ljava/lang/String;)V
    .locals 0

    iput-object p1, p0, Lchat/ola/vn/entity/e;->R:Ljava/lang/String;

    return-void
.end method

.method public k(Ljava/util/List;)V
    .locals 0
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "(",
            "Ljava/util/List<",
            "Lchat/ola/vn/entity/e;",
            ">;)V"
        }
    .end annotation

    iput-object p1, p0, Lchat/ola/vn/entity/e;->K:Ljava/util/List;

    return-void
.end method

.method public k()Z
    .locals 6

    invoke-static {}, Ljava/lang/System;->currentTimeMillis()J

    move-result-wide v0

    iget-wide v2, p0, Lchat/ola/vn/entity/e;->C:J

    sub-long v4, v0, v2

    const-wide/16 v0, 0x2710

    cmp-long v2, v4, v0

    if-lez v2, :cond_0

    const/4 v0, 0x0

    iput-boolean v0, p0, Lchat/ola/vn/entity/e;->v:Z

    :cond_0
    iget-boolean v0, p0, Lchat/ola/vn/entity/e;->v:Z

    return v0
.end method

.method public l()Lchat/ola/vn/entity/e;
    .locals 2

    iget-object v0, p0, Lchat/ola/vn/entity/e;->B:Lchat/ola/vn/entity/e;

    if-nez v0, :cond_0

    iget-object v0, p0, Lchat/ola/vn/entity/e;->t:Ljava/util/List;

    if-eqz v0, :cond_0

    iget-object v0, p0, Lchat/ola/vn/entity/e;->t:Ljava/util/List;

    invoke-interface {v0}, Ljava/util/List;->isEmpty()Z

    move-result v0

    if-nez v0, :cond_0

    iget-object v0, p0, Lchat/ola/vn/entity/e;->t:Ljava/util/List;

    const/4 v1, 0x0

    invoke-interface {v0, v1}, Ljava/util/List;->get(I)Ljava/lang/Object;

    move-result-object v0

    check-cast v0, Lchat/ola/vn/entity/e;

    iput-object v0, p0, Lchat/ola/vn/entity/e;->B:Lchat/ola/vn/entity/e;

    :cond_0
    iget-object v0, p0, Lchat/ola/vn/entity/e;->B:Lchat/ola/vn/entity/e;

    return-object v0
.end method

.method public l(Ljava/util/List;)V
    .locals 0
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "(",
            "Ljava/util/List<",
            "Lchat/ola/vn/entity/e;",
            ">;)V"
        }
    .end annotation

    iput-object p1, p0, Lchat/ola/vn/entity/e;->Q:Ljava/util/List;

    return-void
.end method

.method public m()Ljava/util/List;
    .locals 1
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "()",
            "Ljava/util/List<",
            "Lchat/ola/vn/entity/e;",
            ">;"
        }
    .end annotation

    iget-object v0, p0, Lchat/ola/vn/entity/e;->t:Ljava/util/List;

    return-object v0
.end method

.method public n()Z
    .locals 1

    iget-boolean v0, p0, Lchat/ola/vn/entity/e;->x:Z

    return v0
.end method

.method public o()Z
    .locals 1

    iget-boolean v0, p0, Lchat/ola/vn/entity/e;->y:Z

    return v0
.end method

.method public p()Z
    .locals 1

    iget-boolean v0, p0, Lchat/ola/vn/entity/e;->w:Z

    return v0
.end method

.method public q()Ljava/lang/String;
    .locals 1

    iget-object v0, p0, Lchat/ola/vn/entity/e;->e:Ljava/lang/String;

    return-object v0
.end method

.method public r()Ljava/lang/String;
    .locals 1

    iget-object v0, p0, Lchat/ola/vn/entity/e;->f:Ljava/lang/String;

    return-object v0
.end method

.method public s()Ljava/lang/String;
    .locals 1

    iget-object v0, p0, Lchat/ola/vn/entity/e;->g:Ljava/lang/String;

    return-object v0
.end method

.method public t()Ljava/lang/String;
    .locals 1

    iget-object v0, p0, Lchat/ola/vn/entity/e;->b:Ljava/lang/String;

    return-object v0
.end method

.method public u()I
    .locals 1

    iget-object v0, p0, Lchat/ola/vn/entity/e;->q:Ljava/util/List;

    if-nez v0, :cond_0

    const/4 v0, 0x0

    return v0

    :cond_0
    iget-object v0, p0, Lchat/ola/vn/entity/e;->q:Ljava/util/List;

    invoke-interface {v0}, Ljava/util/List;->size()I

    move-result v0

    return v0
.end method

.method public v()Ljava/util/List;
    .locals 1
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "()",
            "Ljava/util/List<",
            "Lchat/ola/vn/entity/e;",
            ">;"
        }
    .end annotation

    iget-object v0, p0, Lchat/ola/vn/entity/e;->q:Ljava/util/List;

    return-object v0
.end method

.method public w()Ljava/util/List;
    .locals 2
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "()",
            "Ljava/util/List<",
            "Lchat/ola/vn/entity/e;",
            ">;"
        }
    .end annotation

    iget-object v0, p0, Lchat/ola/vn/entity/e;->s:Ljava/util/List;

    if-eqz v0, :cond_0

    iget-object v0, p0, Lchat/ola/vn/entity/e;->r:Ljava/util/List;

    if-nez v0, :cond_0

    iget-object v0, p0, Lchat/ola/vn/entity/e;->s:Ljava/util/List;

    invoke-interface {v0}, Ljava/util/List;->iterator()Ljava/util/Iterator;

    move-result-object v0

    :goto_0
    invoke-interface {v0}, Ljava/util/Iterator;->hasNext()Z

    move-result v1

    if-eqz v1, :cond_0

    invoke-interface {v0}, Ljava/util/Iterator;->next()Ljava/lang/Object;

    move-result-object v1

    check-cast v1, Lchat/ola/vn/entity/e;

    invoke-virtual {v1}, Lchat/ola/vn/entity/e;->w()Ljava/util/List;

    move-result-object v1

    invoke-virtual {p0, v1}, Lchat/ola/vn/entity/e;->i(Ljava/util/List;)V

    goto :goto_0

    :cond_0
    iget-object v0, p0, Lchat/ola/vn/entity/e;->r:Ljava/util/List;

    return-object v0
.end method

.method public x()Ljava/util/List;
    .locals 1
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "()",
            "Ljava/util/List<",
            "Lchat/ola/vn/entity/e;",
            ">;"
        }
    .end annotation

    iget-object v0, p0, Lchat/ola/vn/entity/e;->s:Ljava/util/List;

    return-object v0
.end method

.method public y()Ljava/lang/String;
    .locals 1

    iget-object v0, p0, Lchat/ola/vn/entity/e;->c:Ljava/lang/String;

    return-object v0
.end method

.method public z()Ljava/lang/String;
    .locals 1

    iget-object v0, p0, Lchat/ola/vn/entity/e;->d:Ljava/lang/String;

    return-object v0
.end method
