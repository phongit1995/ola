.class public Lchat/ola/vn/message/v;
.super Lchat/ola/vn/message/d;


# instance fields
.field public A:Ljava/lang/String;

.field public B:Ljava/lang/String;

.field public C:J

.field public D:I

.field public E:I

.field public F:B

.field public G:B

.field public H:B

.field public I:B

.field public J:Z

.field public K:Z

.field private L:Ljava/util/List;
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "Ljava/util/List<",
            "Ljava/lang/String;",
            ">;"
        }
    .end annotation
.end field

.field private M:Ljava/lang/CharSequence;

.field public z:Lchat/ola/vn/entity/ah;


# direct methods
.method public constructor <init>()V
    .locals 4

    const/4 v0, 0x0

    const/4 v1, 0x0

    invoke-direct {p0, v0, v1, v1}, Lchat/ola/vn/message/d;-><init>(Lchat/ola/vn/message/d;BB)V

    iput-object v0, p0, Lchat/ola/vn/message/v;->z:Lchat/ola/vn/entity/ah;

    iput-object v0, p0, Lchat/ola/vn/message/v;->A:Ljava/lang/String;

    iput-object v0, p0, Lchat/ola/vn/message/v;->B:Ljava/lang/String;

    const-wide/16 v2, 0x0

    iput-wide v2, p0, Lchat/ola/vn/message/v;->C:J

    iput v1, p0, Lchat/ola/vn/message/v;->D:I

    iput v1, p0, Lchat/ola/vn/message/v;->E:I

    const/4 v0, -0x1

    iput-byte v0, p0, Lchat/ola/vn/message/v;->F:B

    iput-byte v1, p0, Lchat/ola/vn/message/v;->G:B

    iput-byte v0, p0, Lchat/ola/vn/message/v;->H:B

    iput-byte v1, p0, Lchat/ola/vn/message/v;->I:B

    iput-boolean v1, p0, Lchat/ola/vn/message/v;->J:Z

    iput-boolean v1, p0, Lchat/ola/vn/message/v;->K:Z

    return-void
.end method


# virtual methods
.method public C()Ljava/lang/String;
    .locals 1

    :try_start_0
    iget-object v0, p0, Lchat/ola/vn/message/v;->M:Ljava/lang/CharSequence;

    invoke-interface {v0}, Ljava/lang/CharSequence;->toString()Ljava/lang/String;

    move-result-object v0
    :try_end_0
    .catch Ljava/lang/Throwable; {:try_start_0 .. :try_end_0} :catch_0

    return-object v0

    :catch_0
    const/4 v0, 0x0

    return-object v0
.end method

.method public D()Ljava/lang/CharSequence;
    .locals 1

    iget-object v0, p0, Lchat/ola/vn/message/v;->M:Ljava/lang/CharSequence;

    return-object v0
.end method

.method public a()Ljava/util/List;
    .locals 1
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "()",
            "Ljava/util/List<",
            "Ljava/lang/String;",
            ">;"
        }
    .end annotation

    iget-object v0, p0, Lchat/ola/vn/message/v;->L:Ljava/util/List;

    return-object v0
.end method

.method public f(Ljava/lang/String;)V
    .locals 3

    invoke-super {p0, p1}, Lchat/ola/vn/message/d;->f(Ljava/lang/String;)V

    invoke-static {p1}, Lchat/ola/vn/util/m;->a(Ljava/lang/String;)Z

    move-result v0

    if-nez v0, :cond_2

    invoke-static {p1}, Lchat/ola/vn/util/i;->b(Ljava/lang/CharSequence;)Ljava/util/ArrayList;

    move-result-object v0

    iput-object v0, p0, Lchat/ola/vn/message/v;->L:Ljava/util/List;

    iget-object v0, p0, Lchat/ola/vn/message/v;->L:Ljava/util/List;

    if-eqz v0, :cond_1

    iget-object v0, p0, Lchat/ola/vn/message/v;->L:Ljava/util/List;

    invoke-interface {v0}, Ljava/util/List;->iterator()Ljava/util/Iterator;

    move-result-object v0

    :cond_0
    :goto_0
    invoke-interface {v0}, Ljava/util/Iterator;->hasNext()Z

    move-result v1

    if-eqz v1, :cond_1

    invoke-interface {v0}, Ljava/util/Iterator;->next()Ljava/lang/Object;

    move-result-object v1

    check-cast v1, Ljava/lang/String;

    invoke-static {v1}, Lchat/ola/vn/entity/i;->i(Ljava/lang/String;)C

    move-result v1

    const/4 v2, 0x1

    if-eq v1, v2, :cond_0

    invoke-interface {v0}, Ljava/util/Iterator;->remove()V

    goto :goto_0

    :cond_1
    const-string v0, ""

    invoke-static {p1, v0}, Lchat/ola/vn/util/i;->d(Ljava/lang/CharSequence;Ljava/lang/String;)Ljava/lang/String;

    move-result-object p1

    iput-object p1, p0, Lchat/ola/vn/message/v;->M:Ljava/lang/CharSequence;

    :cond_2
    return-void
.end method
