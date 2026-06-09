.class public Lchat/ola/vn/entity/ad;
.super Ljava/lang/Object;


# instance fields
.field protected a:Ljava/util/List;
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "Ljava/util/List<",
            "Lchat/ola/vn/entity/ad;",
            ">;"
        }
    .end annotation
.end field

.field protected b:Ljava/lang/String;

.field protected c:Ljava/lang/String;

.field protected d:Ljava/lang/String;

.field protected e:[Ljava/lang/String;

.field protected f:Ljava/lang/String;

.field protected g:Ljava/lang/String;

.field protected h:Ljava/lang/String;

.field protected i:Ljava/lang/String;

.field protected j:Ljava/lang/String;

.field protected k:J

.field protected l:J

.field protected m:J

.field protected n:I

.field protected o:I

.field protected p:I

.field protected q:S

.field protected r:S

.field protected s:I

.field protected t:I

.field private u:Ljava/util/List;
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "Ljava/util/List<",
            "Ljava/lang/String;",
            ">;"
        }
    .end annotation
.end field


# direct methods
.method public constructor <init>()V
    .locals 2

    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    const-wide/16 v0, 0x0

    iput-wide v0, p0, Lchat/ola/vn/entity/ad;->l:J

    iput-wide v0, p0, Lchat/ola/vn/entity/ad;->m:J

    const/4 v0, 0x0

    iput v0, p0, Lchat/ola/vn/entity/ad;->p:I

    iput v0, p0, Lchat/ola/vn/entity/ad;->s:I

    iput v0, p0, Lchat/ola/vn/entity/ad;->t:I

    return-void
.end method


# virtual methods
.method public A()J
    .locals 2

    iget-wide v0, p0, Lchat/ola/vn/entity/ad;->m:J

    return-wide v0
.end method

.method public B()Ljava/util/List;
    .locals 1
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "()",
            "Ljava/util/List<",
            "Lchat/ola/vn/entity/ad;",
            ">;"
        }
    .end annotation

    iget-object v0, p0, Lchat/ola/vn/entity/ad;->a:Ljava/util/List;

    return-object v0
.end method

.method public a(S)V
    .locals 0

    iput-short p1, p0, Lchat/ola/vn/entity/ad;->r:S

    return-void
.end method

.method public a([Ljava/lang/String;)V
    .locals 0

    iput-object p1, p0, Lchat/ola/vn/entity/ad;->e:[Ljava/lang/String;

    return-void
.end method

.method public b(I)V
    .locals 0

    iput p1, p0, Lchat/ola/vn/entity/ad;->n:I

    return-void
.end method

.method public b(S)V
    .locals 0

    iput-short p1, p0, Lchat/ola/vn/entity/ad;->q:S

    return-void
.end method

.method public c(I)V
    .locals 0

    iput p1, p0, Lchat/ola/vn/entity/ad;->o:I

    return-void
.end method

.method public c(J)V
    .locals 0

    iput-wide p1, p0, Lchat/ola/vn/entity/ad;->k:J

    return-void
.end method

.method public c(Ljava/lang/String;)V
    .locals 0

    iput-object p1, p0, Lchat/ola/vn/entity/ad;->g:Ljava/lang/String;

    return-void
.end method

.method public d(I)Ljava/lang/String;
    .locals 3

    iget-object v0, p0, Lchat/ola/vn/entity/ad;->u:Ljava/util/List;

    const/4 v1, 0x0

    if-nez v0, :cond_1

    iget-object v0, p0, Lchat/ola/vn/entity/ad;->f:Ljava/lang/String;

    if-nez v0, :cond_0

    return-object v1

    :cond_0
    iget-object v0, p0, Lchat/ola/vn/entity/ad;->f:Ljava/lang/String;

    const-string v2, ";"

    invoke-virtual {v0, v2}, Ljava/lang/String;->split(Ljava/lang/String;)[Ljava/lang/String;

    move-result-object v0

    new-instance v2, Ljava/util/ArrayList;

    invoke-static {v0}, Ljava/util/Arrays;->asList([Ljava/lang/Object;)Ljava/util/List;

    move-result-object v0

    invoke-direct {v2, v0}, Ljava/util/ArrayList;-><init>(Ljava/util/Collection;)V

    iput-object v2, p0, Lchat/ola/vn/entity/ad;->u:Ljava/util/List;

    :cond_1
    if-ltz p1, :cond_3

    iget-object v0, p0, Lchat/ola/vn/entity/ad;->u:Ljava/util/List;

    invoke-interface {v0}, Ljava/util/List;->size()I

    move-result v0

    if-lt p1, v0, :cond_2

    return-object v1

    :cond_2
    iget-object v0, p0, Lchat/ola/vn/entity/ad;->u:Ljava/util/List;

    invoke-interface {v0, p1}, Ljava/util/List;->get(I)Ljava/lang/Object;

    move-result-object p1

    check-cast p1, Ljava/lang/String;

    return-object p1

    :cond_3
    return-object v1
.end method

.method public d(J)V
    .locals 0

    iput-wide p1, p0, Lchat/ola/vn/entity/ad;->l:J

    return-void
.end method

.method public d(Ljava/lang/String;)V
    .locals 0

    iput-object p1, p0, Lchat/ola/vn/entity/ad;->h:Ljava/lang/String;

    return-void
.end method

.method public d(Ljava/util/List;)V
    .locals 0
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "(",
            "Ljava/util/List<",
            "Lchat/ola/vn/entity/ad;",
            ">;)V"
        }
    .end annotation

    iput-object p1, p0, Lchat/ola/vn/entity/ad;->a:Ljava/util/List;

    return-void
.end method

.method public e(I)V
    .locals 0

    iput p1, p0, Lchat/ola/vn/entity/ad;->p:I

    return-void
.end method

.method public e(J)V
    .locals 0

    iput-wide p1, p0, Lchat/ola/vn/entity/ad;->m:J

    return-void
.end method

.method public e(Ljava/lang/String;)V
    .locals 0

    iput-object p1, p0, Lchat/ola/vn/entity/ad;->d:Ljava/lang/String;

    return-void
.end method

.method public f(I)V
    .locals 0

    iput p1, p0, Lchat/ola/vn/entity/ad;->s:I

    return-void
.end method

.method public f(Ljava/lang/String;)V
    .locals 0

    iput-object p1, p0, Lchat/ola/vn/entity/ad;->c:Ljava/lang/String;

    return-void
.end method

.method public g(I)V
    .locals 0

    iput p1, p0, Lchat/ola/vn/entity/ad;->t:I

    return-void
.end method

.method public g(Ljava/lang/String;)V
    .locals 0

    iput-object p1, p0, Lchat/ola/vn/entity/ad;->f:Ljava/lang/String;

    return-void
.end method

.method public h()Ljava/lang/String;
    .locals 1

    iget-object v0, p0, Lchat/ola/vn/entity/ad;->h:Ljava/lang/String;

    return-object v0
.end method

.method public h(Ljava/lang/String;)V
    .locals 0

    iput-object p1, p0, Lchat/ola/vn/entity/ad;->i:Ljava/lang/String;

    return-void
.end method

.method public i(Ljava/lang/String;)V
    .locals 0

    iput-object p1, p0, Lchat/ola/vn/entity/ad;->j:Ljava/lang/String;

    return-void
.end method

.method public j(Ljava/lang/String;)V
    .locals 0

    iput-object p1, p0, Lchat/ola/vn/entity/ad;->b:Ljava/lang/String;

    return-void
.end method

.method public m()S
    .locals 1

    iget-short v0, p0, Lchat/ola/vn/entity/ad;->r:S

    return v0
.end method

.method public n()Ljava/lang/String;
    .locals 1

    iget-object v0, p0, Lchat/ola/vn/entity/ad;->g:Ljava/lang/String;

    return-object v0
.end method

.method public o()Ljava/lang/String;
    .locals 1

    iget-object v0, p0, Lchat/ola/vn/entity/ad;->d:Ljava/lang/String;

    return-object v0
.end method

.method public p()Ljava/lang/String;
    .locals 1

    iget-object v0, p0, Lchat/ola/vn/entity/ad;->c:Ljava/lang/String;

    return-object v0
.end method

.method public q()[Ljava/lang/String;
    .locals 1

    iget-object v0, p0, Lchat/ola/vn/entity/ad;->e:[Ljava/lang/String;

    return-object v0
.end method

.method public r()J
    .locals 2

    iget-wide v0, p0, Lchat/ola/vn/entity/ad;->k:J

    return-wide v0
.end method

.method public s()I
    .locals 1

    iget v0, p0, Lchat/ola/vn/entity/ad;->n:I

    return v0
.end method

.method public t()I
    .locals 1

    iget v0, p0, Lchat/ola/vn/entity/ad;->o:I

    return v0
.end method

.method public u()Ljava/lang/String;
    .locals 1

    iget-object v0, p0, Lchat/ola/vn/entity/ad;->f:Ljava/lang/String;

    return-object v0
.end method

.method public v()S
    .locals 1

    iget-short v0, p0, Lchat/ola/vn/entity/ad;->q:S

    return v0
.end method

.method public w()Ljava/lang/String;
    .locals 1

    iget-object v0, p0, Lchat/ola/vn/entity/ad;->i:Ljava/lang/String;

    return-object v0
.end method

.method public x()Ljava/lang/String;
    .locals 1

    iget-object v0, p0, Lchat/ola/vn/entity/ad;->j:Ljava/lang/String;

    return-object v0
.end method

.method public y()J
    .locals 2

    iget-wide v0, p0, Lchat/ola/vn/entity/ad;->l:J

    return-wide v0
.end method

.method public z()I
    .locals 1

    iget v0, p0, Lchat/ola/vn/entity/ad;->p:I

    return v0
.end method
