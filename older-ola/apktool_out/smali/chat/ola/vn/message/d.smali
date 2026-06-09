.class public Lchat/ola/vn/message/d;
.super Ljava/lang/Object;


# instance fields
.field protected a:Lchat/ola/vn/message/f;

.field protected b:B

.field protected c:B

.field protected d:Ljava/lang/String;

.field protected e:Ljava/lang/String;

.field protected f:Ljava/lang/String;

.field protected g:Ljava/lang/CharSequence;

.field protected h:Ljava/lang/String;

.field protected i:Ljava/lang/String;

.field protected j:Ljava/lang/String;

.field protected k:Ljava/lang/String;

.field protected l:Ljava/lang/String;

.field protected m:Ljava/lang/String;

.field protected n:Ljava/lang/String;

.field protected o:J

.field public p:Ljava/lang/Long;

.field protected q:J

.field protected r:S

.field protected s:S

.field protected t:S

.field protected u:B

.field public v:Z

.field public w:Z

.field public x:Z

.field protected y:Ljava/lang/Runnable;

.field private z:Ljava/util/List;
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
    .locals 4

    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    const/4 v0, 0x0

    iput-byte v0, p0, Lchat/ola/vn/message/d;->b:B

    iput-byte v0, p0, Lchat/ola/vn/message/d;->c:B

    const/4 v1, 0x0

    iput-object v1, p0, Lchat/ola/vn/message/d;->f:Ljava/lang/String;

    iput-object v1, p0, Lchat/ola/vn/message/d;->g:Ljava/lang/CharSequence;

    invoke-static {}, Ljava/lang/System;->currentTimeMillis()J

    move-result-wide v2

    iput-wide v2, p0, Lchat/ola/vn/message/d;->o:J

    iput-object v1, p0, Lchat/ola/vn/message/d;->p:Ljava/lang/Long;

    const-wide/16 v2, 0x0

    iput-wide v2, p0, Lchat/ola/vn/message/d;->q:J

    iput-byte v0, p0, Lchat/ola/vn/message/d;->u:B

    iput-boolean v0, p0, Lchat/ola/vn/message/d;->v:Z

    iput-boolean v0, p0, Lchat/ola/vn/message/d;->w:Z

    iput-boolean v0, p0, Lchat/ola/vn/message/d;->x:Z

    iput-object v1, p0, Lchat/ola/vn/message/d;->z:Ljava/util/List;

    iput-object v1, p0, Lchat/ola/vn/message/d;->y:Ljava/lang/Runnable;

    invoke-direct {p0}, Lchat/ola/vn/message/d;->a()Ljava/lang/String;

    move-result-object v0

    iput-object v0, p0, Lchat/ola/vn/message/d;->l:Ljava/lang/String;

    return-void
.end method

.method public constructor <init>(B)V
    .locals 0

    invoke-direct {p0}, Lchat/ola/vn/message/d;-><init>()V

    iput-byte p1, p0, Lchat/ola/vn/message/d;->b:B

    return-void
.end method

.method public constructor <init>(Lchat/ola/vn/message/d;BB)V
    .locals 0

    invoke-direct {p0}, Lchat/ola/vn/message/d;-><init>()V

    if-eqz p1, :cond_0

    invoke-virtual {p0, p1}, Lchat/ola/vn/message/d;->a(Lchat/ola/vn/message/d;)V

    :cond_0
    iput-byte p2, p0, Lchat/ola/vn/message/d;->b:B

    iput-byte p3, p0, Lchat/ola/vn/message/d;->c:B

    return-void
.end method

.method private a()Ljava/lang/String;
    .locals 3

    new-instance v0, Ljava/lang/StringBuilder;

    invoke-direct {v0}, Ljava/lang/StringBuilder;-><init>()V

    const-string v1, "client."

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    invoke-static {}, Ljava/lang/System;->nanoTime()J

    move-result-wide v1

    invoke-virtual {v0, v1, v2}, Ljava/lang/StringBuilder;->append(J)Ljava/lang/StringBuilder;

    invoke-virtual {v0}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v0

    return-object v0
.end method

.method public static g(Ljava/lang/String;)Z
    .locals 1

    :try_start_0
    const-string v0, "client."

    invoke-virtual {p0, v0}, Ljava/lang/String;->startsWith(Ljava/lang/String;)Z

    move-result p0
    :try_end_0
    .catch Ljava/lang/Throwable; {:try_start_0 .. :try_end_0} :catch_0

    return p0

    :catch_0
    const/4 p0, 0x0

    return p0
.end method


# virtual methods
.method public A()Ljava/lang/String;
    .locals 1

    iget-object v0, p0, Lchat/ola/vn/message/d;->n:Ljava/lang/String;

    return-object v0
.end method

.method public B()Ljava/lang/String;
    .locals 1

    iget-object v0, p0, Lchat/ola/vn/message/d;->k:Ljava/lang/String;

    return-object v0
.end method

.method public a(I)Ljava/lang/String;
    .locals 1

    :try_start_0
    iget-object v0, p0, Lchat/ola/vn/message/d;->z:Ljava/util/List;

    invoke-interface {v0, p1}, Ljava/util/List;->get(I)Ljava/lang/Object;

    move-result-object p1

    check-cast p1, Ljava/lang/String;
    :try_end_0
    .catch Ljava/lang/Throwable; {:try_start_0 .. :try_end_0} :catch_0

    return-object p1

    :catch_0
    :try_start_1
    iget-object p1, p0, Lchat/ola/vn/message/d;->a:Lchat/ola/vn/message/f;

    invoke-virtual {p1}, Lchat/ola/vn/message/f;->k()S

    move-result p1

    if-nez p1, :cond_0

    iget-byte p1, p0, Lchat/ola/vn/message/d;->u:B

    const/4 v0, 0x3

    if-ne p1, v0, :cond_0

    iget-object p1, p0, Lchat/ola/vn/message/d;->a:Lchat/ola/vn/message/f;

    iget-object p1, p1, Lchat/ola/vn/message/f;->d:Ljava/lang/String;
    :try_end_1
    .catch Ljava/lang/Throwable; {:try_start_1 .. :try_end_1} :catch_1

    return-object p1

    :catch_1
    :cond_0
    const/4 p1, 0x0

    return-object p1
.end method

.method public a(B)V
    .locals 2

    iget-byte v0, p0, Lchat/ola/vn/message/d;->u:B

    const/4 v1, 0x3

    if-ne v0, v1, :cond_0

    return-void

    :cond_0
    iget-byte v0, p0, Lchat/ola/vn/message/d;->u:B

    if-eq v0, p1, :cond_1

    iput-byte p1, p0, Lchat/ola/vn/message/d;->u:B

    :cond_1
    return-void
.end method

.method public a(BZ)V
    .locals 4

    iget-byte v0, p0, Lchat/ola/vn/message/d;->u:B

    iget-byte v1, p0, Lchat/ola/vn/message/d;->u:B

    const/4 v2, 0x3

    if-ne v1, v2, :cond_0

    return-void

    :cond_0
    invoke-virtual {p0}, Lchat/ola/vn/message/d;->h()Z

    move-result v1

    if-nez v1, :cond_1

    if-ne p1, v2, :cond_1

    return-void

    :cond_1
    iget-byte v1, p0, Lchat/ola/vn/message/d;->u:B

    if-eq v1, p1, :cond_3

    iget-byte v1, p0, Lchat/ola/vn/message/d;->u:B

    iput-byte p1, p0, Lchat/ola/vn/message/d;->u:B

    if-eqz p2, :cond_2

    const/4 p2, 0x2

    if-ne v0, p2, :cond_2

    :try_start_0
    iget-byte p2, p0, Lchat/ola/vn/message/d;->b:B

    const/4 v0, 0x1

    if-ne p2, v0, :cond_2

    if-ne p1, v2, :cond_2

    sget-object p2, Lchat/ola/vn/OlaApplication;->b:Lchat/ola/vn/network/OlaNetworkService;

    iget-object v0, p0, Lchat/ola/vn/message/d;->a:Lchat/ola/vn/message/f;

    invoke-virtual {v0}, Lchat/ola/vn/message/f;->j()Ljava/lang/String;

    move-result-object v0

    iget-object v2, p0, Lchat/ola/vn/message/d;->a:Lchat/ola/vn/message/f;

    invoke-virtual {v2}, Lchat/ola/vn/message/f;->k()S

    move-result v2

    iget-object v3, p0, Lchat/ola/vn/message/d;->l:Ljava/lang/String;

    int-to-short p1, p1

    invoke-virtual {p2, v0, v2, v3, p1}, Lchat/ola/vn/network/OlaNetworkService;->a(Ljava/lang/String;SLjava/lang/String;S)V
    :try_end_0
    .catch Ljava/lang/Throwable; {:try_start_0 .. :try_end_0} :catch_0

    :catch_0
    :cond_2
    iget-object p1, p0, Lchat/ola/vn/message/d;->a:Lchat/ola/vn/message/f;

    if-eqz p1, :cond_3

    iget-object p1, p0, Lchat/ola/vn/message/d;->a:Lchat/ola/vn/message/f;

    iget-byte p2, p0, Lchat/ola/vn/message/d;->u:B

    invoke-virtual {p1, p0, v1, p2}, Lchat/ola/vn/message/f;->a(Lchat/ola/vn/message/d;BB)V

    :cond_3
    return-void
.end method

.method public a(J)V
    .locals 0

    iput-wide p1, p0, Lchat/ola/vn/message/d;->o:J

    return-void
.end method

.method a(Lchat/ola/vn/message/d;)V
    .locals 2

    invoke-virtual {p1}, Lchat/ola/vn/message/d;->i()Ljava/lang/String;

    move-result-object v0

    iput-object v0, p0, Lchat/ola/vn/message/d;->d:Ljava/lang/String;

    invoke-virtual {p1}, Lchat/ola/vn/message/d;->j()Ljava/lang/String;

    move-result-object v0

    iput-object v0, p0, Lchat/ola/vn/message/d;->e:Ljava/lang/String;

    invoke-virtual {p1}, Lchat/ola/vn/message/d;->k()Ljava/lang/String;

    move-result-object v0

    iput-object v0, p0, Lchat/ola/vn/message/d;->f:Ljava/lang/String;

    invoke-virtual {p1}, Lchat/ola/vn/message/d;->l()Ljava/lang/CharSequence;

    move-result-object v0

    iput-object v0, p0, Lchat/ola/vn/message/d;->g:Ljava/lang/CharSequence;

    invoke-virtual {p1}, Lchat/ola/vn/message/d;->c()Ljava/lang/String;

    move-result-object v0

    if-eqz v0, :cond_0

    invoke-virtual {p1}, Lchat/ola/vn/message/d;->c()Ljava/lang/String;

    move-result-object v0

    iput-object v0, p0, Lchat/ola/vn/message/d;->h:Ljava/lang/String;

    invoke-virtual {p1}, Lchat/ola/vn/message/d;->v()Ljava/lang/String;

    move-result-object v0

    iput-object v0, p0, Lchat/ola/vn/message/d;->i:Ljava/lang/String;

    :cond_0
    invoke-virtual {p1}, Lchat/ola/vn/message/d;->r()Ljava/lang/String;

    move-result-object v0

    invoke-static {v0}, Lchat/ola/vn/util/m;->a(Ljava/lang/String;)Z

    move-result v0

    if-nez v0, :cond_1

    invoke-virtual {p1}, Lchat/ola/vn/message/d;->r()Ljava/lang/String;

    move-result-object v0

    iput-object v0, p0, Lchat/ola/vn/message/d;->m:Ljava/lang/String;

    :cond_1
    invoke-virtual {p1}, Lchat/ola/vn/message/d;->m()J

    move-result-wide v0

    iput-wide v0, p0, Lchat/ola/vn/message/d;->o:J

    invoke-virtual {p1}, Lchat/ola/vn/message/d;->n()S

    move-result v0

    iput-short v0, p0, Lchat/ola/vn/message/d;->s:S

    invoke-virtual {p1}, Lchat/ola/vn/message/d;->o()S

    move-result v0

    iput-short v0, p0, Lchat/ola/vn/message/d;->t:S

    invoke-virtual {p1}, Lchat/ola/vn/message/d;->t()J

    move-result-wide v0

    iput-wide v0, p0, Lchat/ola/vn/message/d;->q:J

    invoke-virtual {p1}, Lchat/ola/vn/message/d;->q()B

    move-result v0

    iput-byte v0, p0, Lchat/ola/vn/message/d;->u:B

    iget-boolean v0, p1, Lchat/ola/vn/message/d;->v:Z

    iput-boolean v0, p0, Lchat/ola/vn/message/d;->v:Z

    iget-object v0, p1, Lchat/ola/vn/message/d;->n:Ljava/lang/String;

    invoke-static {v0}, Lchat/ola/vn/util/m;->a(Ljava/lang/String;)Z

    move-result v0

    if-nez v0, :cond_2

    iget-object v0, p1, Lchat/ola/vn/message/d;->n:Ljava/lang/String;

    iput-object v0, p0, Lchat/ola/vn/message/d;->n:Ljava/lang/String;

    :cond_2
    iget-boolean v0, p0, Lchat/ola/vn/message/d;->w:Z

    if-nez v0, :cond_3

    iget-boolean v0, p1, Lchat/ola/vn/message/d;->w:Z

    iput-boolean v0, p0, Lchat/ola/vn/message/d;->w:Z

    :cond_3
    iget-boolean v0, p0, Lchat/ola/vn/message/d;->x:Z

    if-nez v0, :cond_4

    iget-boolean v0, p1, Lchat/ola/vn/message/d;->x:Z

    iput-boolean v0, p0, Lchat/ola/vn/message/d;->x:Z

    :cond_4
    iget-object v0, p0, Lchat/ola/vn/message/d;->p:Ljava/lang/Long;

    if-nez v0, :cond_5

    iget-object p1, p1, Lchat/ola/vn/message/d;->p:Ljava/lang/Long;

    iput-object p1, p0, Lchat/ola/vn/message/d;->p:Ljava/lang/Long;

    :cond_5
    return-void
.end method

.method public a(Ljava/lang/Runnable;)V
    .locals 0

    iput-object p1, p0, Lchat/ola/vn/message/d;->y:Ljava/lang/Runnable;

    return-void
.end method

.method public a(Ljava/util/List;)V
    .locals 0
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "(",
            "Ljava/util/List<",
            "Ljava/lang/String;",
            ">;)V"
        }
    .end annotation

    iput-object p1, p0, Lchat/ola/vn/message/d;->z:Ljava/util/List;

    return-void
.end method

.method public a(S)V
    .locals 0

    iput-short p1, p0, Lchat/ola/vn/message/d;->s:S

    return-void
.end method

.method public b(B)V
    .locals 1

    const/4 v0, 0x1

    invoke-virtual {p0, p1, v0}, Lchat/ola/vn/message/d;->a(BZ)V

    return-void
.end method

.method public b(J)V
    .locals 0

    iput-wide p1, p0, Lchat/ola/vn/message/d;->q:J

    return-void
.end method

.method public b(Ljava/lang/String;)V
    .locals 0

    iput-object p1, p0, Lchat/ola/vn/message/d;->h:Ljava/lang/String;

    return-void
.end method

.method public b(S)V
    .locals 0

    iput-short p1, p0, Lchat/ola/vn/message/d;->t:S

    return-void
.end method

.method public b()Z
    .locals 1

    const/4 v0, 0x1

    return v0
.end method

.method public c()Ljava/lang/String;
    .locals 1

    iget-object v0, p0, Lchat/ola/vn/message/d;->h:Ljava/lang/String;

    return-object v0
.end method

.method public c(Ljava/lang/String;)V
    .locals 1

    iget-object v0, p0, Lchat/ola/vn/message/d;->z:Ljava/util/List;

    if-nez v0, :cond_0

    new-instance v0, Ljava/util/ArrayList;

    invoke-direct {v0}, Ljava/util/ArrayList;-><init>()V

    iput-object v0, p0, Lchat/ola/vn/message/d;->z:Ljava/util/List;

    :cond_0
    iget-object v0, p0, Lchat/ola/vn/message/d;->z:Ljava/util/List;

    invoke-interface {v0, p1}, Ljava/util/List;->contains(Ljava/lang/Object;)Z

    move-result v0

    if-nez v0, :cond_1

    iget-object v0, p0, Lchat/ola/vn/message/d;->z:Ljava/util/List;

    invoke-interface {v0, p1}, Ljava/util/List;->add(Ljava/lang/Object;)Z

    :cond_1
    return-void
.end method

.method public c(S)V
    .locals 0

    iput-short p1, p0, Lchat/ola/vn/message/d;->r:S

    return-void
.end method

.method public d()B
    .locals 1

    iget-byte v0, p0, Lchat/ola/vn/message/d;->b:B

    return v0
.end method

.method public d(Ljava/lang/String;)V
    .locals 0

    iput-object p1, p0, Lchat/ola/vn/message/d;->d:Ljava/lang/String;

    return-void
.end method

.method public e()B
    .locals 1

    iget-byte v0, p0, Lchat/ola/vn/message/d;->c:B

    return v0
.end method

.method public e(Ljava/lang/String;)V
    .locals 0

    iput-object p1, p0, Lchat/ola/vn/message/d;->e:Ljava/lang/String;

    return-void
.end method

.method public f()Lchat/ola/vn/message/f;
    .locals 1

    iget-object v0, p0, Lchat/ola/vn/message/d;->a:Lchat/ola/vn/message/f;

    return-object v0
.end method

.method public f(Ljava/lang/String;)V
    .locals 2

    invoke-static {p1}, Lchat/ola/vn/util/i;->g(Ljava/lang/CharSequence;)Ljava/lang/String;

    move-result-object v0

    iput-object v0, p0, Lchat/ola/vn/message/d;->i:Ljava/lang/String;

    iget-object v0, p0, Lchat/ola/vn/message/d;->i:Ljava/lang/String;

    invoke-static {v0}, Lchat/ola/vn/util/m;->a(Ljava/lang/String;)Z

    move-result v0

    if-eqz v0, :cond_0

    invoke-static {p1}, Lchat/ola/vn/util/i;->d(Ljava/lang/CharSequence;)Ljava/lang/String;

    move-result-object v0

    iput-object v0, p0, Lchat/ola/vn/message/d;->h:Ljava/lang/String;

    iget-object v0, p0, Lchat/ola/vn/message/d;->h:Ljava/lang/String;

    invoke-static {v0}, Lchat/ola/vn/util/m;->a(Ljava/lang/String;)Z

    move-result v0

    if-eqz v0, :cond_0

    invoke-static {p1}, Lchat/ola/vn/util/i;->e(Ljava/lang/CharSequence;)Ljava/lang/String;

    move-result-object v0

    iput-object v0, p0, Lchat/ola/vn/message/d;->j:Ljava/lang/String;

    iget-object v0, p0, Lchat/ola/vn/message/d;->j:Ljava/lang/String;

    invoke-static {v0}, Lchat/ola/vn/util/m;->a(Ljava/lang/String;)Z

    move-result v0

    if-eqz v0, :cond_0

    invoke-static {p1}, Lchat/ola/vn/util/i;->f(Ljava/lang/CharSequence;)Ljava/lang/String;

    move-result-object v0

    iput-object v0, p0, Lchat/ola/vn/message/d;->k:Ljava/lang/String;

    :cond_0
    iput-object p1, p0, Lchat/ola/vn/message/d;->f:Ljava/lang/String;

    :try_start_0
    iget-byte v0, p0, Lchat/ola/vn/message/d;->b:B

    const/4 v1, 0x1

    if-ne v0, v1, :cond_1

    const-string v0, ""

    invoke-static {p1, v0}, Lchat/ola/vn/util/i;->d(Ljava/lang/CharSequence;Ljava/lang/String;)Ljava/lang/String;

    move-result-object v0

    invoke-static {v0}, Lchat/ola/vn/util/i;->c(Ljava/lang/String;)Ljava/lang/CharSequence;

    move-result-object v0

    :goto_0
    iput-object v0, p0, Lchat/ola/vn/message/d;->g:Ljava/lang/CharSequence;

    return-void

    :cond_1
    const-string v0, ""

    invoke-static {p1, v0}, Lchat/ola/vn/util/i;->d(Ljava/lang/CharSequence;Ljava/lang/String;)Ljava/lang/String;

    move-result-object v0

    invoke-static {v0}, Lchat/ola/vn/util/i;->b(Ljava/lang/String;)Ljava/lang/CharSequence;

    move-result-object v0
    :try_end_0
    .catch Ljava/lang/Throwable; {:try_start_0 .. :try_end_0} :catch_0

    goto :goto_0

    :catch_0
    iput-object p1, p0, Lchat/ola/vn/message/d;->g:Ljava/lang/CharSequence;

    return-void
.end method

.method public g()V
    .locals 6

    iget-byte v0, p0, Lchat/ola/vn/message/d;->b:B

    const/4 v1, 0x1

    if-ne v0, v1, :cond_1

    iget-byte v0, p0, Lchat/ola/vn/message/d;->u:B

    const/4 v1, 0x3

    if-ne v0, v1, :cond_0

    return-void

    :cond_0
    iget-byte v0, p0, Lchat/ola/vn/message/d;->u:B

    iput-byte v1, p0, Lchat/ola/vn/message/d;->u:B

    :try_start_0
    sget-object v1, Lchat/ola/vn/OlaApplication;->b:Lchat/ola/vn/network/OlaNetworkService;

    iget-object v2, p0, Lchat/ola/vn/message/d;->a:Lchat/ola/vn/message/f;

    invoke-virtual {v2}, Lchat/ola/vn/message/f;->j()Ljava/lang/String;

    move-result-object v2

    iget-object v3, p0, Lchat/ola/vn/message/d;->a:Lchat/ola/vn/message/f;

    invoke-virtual {v3}, Lchat/ola/vn/message/f;->k()S

    move-result v3

    iget-object v4, p0, Lchat/ola/vn/message/d;->l:Ljava/lang/String;

    iget-byte v5, p0, Lchat/ola/vn/message/d;->u:B

    int-to-short v5, v5

    invoke-virtual {v1, v2, v3, v4, v5}, Lchat/ola/vn/network/OlaNetworkService;->a(Ljava/lang/String;SLjava/lang/String;S)V
    :try_end_0
    .catch Ljava/lang/Throwable; {:try_start_0 .. :try_end_0} :catch_0

    :catch_0
    iget-object v1, p0, Lchat/ola/vn/message/d;->a:Lchat/ola/vn/message/f;

    if-eqz v1, :cond_1

    iget-object v1, p0, Lchat/ola/vn/message/d;->a:Lchat/ola/vn/message/f;

    iget-byte v2, p0, Lchat/ola/vn/message/d;->u:B

    invoke-virtual {v1, p0, v0, v2}, Lchat/ola/vn/message/f;->a(Lchat/ola/vn/message/d;BB)V

    :cond_1
    return-void
.end method

.method public h(Ljava/lang/String;)V
    .locals 1

    iget-object v0, p0, Lchat/ola/vn/message/d;->l:Ljava/lang/String;

    invoke-static {v0, p1}, Lchat/ola/vn/util/m;->b(Ljava/lang/String;Ljava/lang/String;)Z

    move-result v0

    if-nez v0, :cond_0

    iget-object v0, p0, Lchat/ola/vn/message/d;->l:Ljava/lang/String;

    iput-object p1, p0, Lchat/ola/vn/message/d;->l:Ljava/lang/String;

    :try_start_0
    iget-object p1, p0, Lchat/ola/vn/message/d;->a:Lchat/ola/vn/message/f;

    invoke-virtual {p1, v0, p0}, Lchat/ola/vn/message/f;->b(Ljava/lang/String;Lchat/ola/vn/message/d;)V
    :try_end_0
    .catch Ljava/lang/Throwable; {:try_start_0 .. :try_end_0} :catch_0

    :catch_0
    :cond_0
    return-void
.end method

.method protected h()Z
    .locals 1

    const/4 v0, 0x1

    return v0
.end method

.method public i()Ljava/lang/String;
    .locals 1

    iget-object v0, p0, Lchat/ola/vn/message/d;->d:Ljava/lang/String;

    return-object v0
.end method

.method public i(Ljava/lang/String;)V
    .locals 0

    iput-object p1, p0, Lchat/ola/vn/message/d;->m:Ljava/lang/String;

    return-void
.end method

.method public j()Ljava/lang/String;
    .locals 1

    iget-object v0, p0, Lchat/ola/vn/message/d;->e:Ljava/lang/String;

    return-object v0
.end method

.method public j(Ljava/lang/String;)V
    .locals 0

    iput-object p1, p0, Lchat/ola/vn/message/d;->i:Ljava/lang/String;

    return-void
.end method

.method public k()Ljava/lang/String;
    .locals 1

    iget-object v0, p0, Lchat/ola/vn/message/d;->f:Ljava/lang/String;

    return-object v0
.end method

.method public k(Ljava/lang/String;)V
    .locals 0

    iput-object p1, p0, Lchat/ola/vn/message/d;->j:Ljava/lang/String;

    return-void
.end method

.method public l()Ljava/lang/CharSequence;
    .locals 1

    iget-object v0, p0, Lchat/ola/vn/message/d;->g:Ljava/lang/CharSequence;

    return-object v0
.end method

.method public l(Ljava/lang/String;)V
    .locals 0

    iput-object p1, p0, Lchat/ola/vn/message/d;->n:Ljava/lang/String;

    return-void
.end method

.method public m()J
    .locals 2

    iget-wide v0, p0, Lchat/ola/vn/message/d;->o:J

    return-wide v0
.end method

.method public m(Ljava/lang/String;)V
    .locals 0

    iput-object p1, p0, Lchat/ola/vn/message/d;->k:Ljava/lang/String;

    return-void
.end method

.method public n()S
    .locals 1

    iget-short v0, p0, Lchat/ola/vn/message/d;->s:S

    return v0
.end method

.method public o()S
    .locals 1

    iget-short v0, p0, Lchat/ola/vn/message/d;->t:S

    return v0
.end method

.method public p()Ljava/lang/String;
    .locals 1

    iget-object v0, p0, Lchat/ola/vn/message/d;->l:Ljava/lang/String;

    if-nez v0, :cond_0

    invoke-direct {p0}, Lchat/ola/vn/message/d;->a()Ljava/lang/String;

    move-result-object v0

    iput-object v0, p0, Lchat/ola/vn/message/d;->l:Ljava/lang/String;

    :cond_0
    iget-object v0, p0, Lchat/ola/vn/message/d;->l:Ljava/lang/String;

    return-object v0
.end method

.method public q()B
    .locals 1

    iget-byte v0, p0, Lchat/ola/vn/message/d;->u:B

    return v0
.end method

.method public r()Ljava/lang/String;
    .locals 1

    iget-object v0, p0, Lchat/ola/vn/message/d;->m:Ljava/lang/String;

    return-object v0
.end method

.method public s()S
    .locals 1

    iget-short v0, p0, Lchat/ola/vn/message/d;->r:S

    return v0
.end method

.method public t()J
    .locals 2

    iget-wide v0, p0, Lchat/ola/vn/message/d;->q:J

    return-wide v0
.end method

.method public u()Ljava/util/List;
    .locals 1
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "()",
            "Ljava/util/List<",
            "Ljava/lang/String;",
            ">;"
        }
    .end annotation

    iget-object v0, p0, Lchat/ola/vn/message/d;->z:Ljava/util/List;

    return-object v0
.end method

.method public v()Ljava/lang/String;
    .locals 1

    iget-object v0, p0, Lchat/ola/vn/message/d;->i:Ljava/lang/String;

    return-object v0
.end method

.method public w()Z
    .locals 1

    const/4 v0, 0x0

    return v0
.end method

.method public x()Z
    .locals 2

    invoke-virtual {p0}, Lchat/ola/vn/message/d;->e()B

    move-result v0

    const/4 v1, 0x2

    if-eq v0, v1, :cond_0

    const/4 v0, 0x0

    return v0

    :cond_0
    const/4 v0, 0x1

    return v0
.end method

.method public y()Ljava/lang/String;
    .locals 1

    iget-object v0, p0, Lchat/ola/vn/message/d;->j:Ljava/lang/String;

    return-object v0
.end method

.method public z()Ljava/lang/Runnable;
    .locals 1

    iget-object v0, p0, Lchat/ola/vn/message/d;->y:Ljava/lang/Runnable;

    return-object v0
.end method
