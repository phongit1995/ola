.class public Lchat/ola/vn/entity/y;
.super Ljava/lang/Object;


# instance fields
.field private a:Ljava/lang/String;

.field private b:Ljava/lang/String;

.field private c:Ljava/lang/String;

.field private d:Ljava/lang/String;

.field private e:Ljava/lang/String;

.field private f:Ljava/util/List;
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "Ljava/util/List<",
            "Ljava/lang/String;",
            ">;"
        }
    .end annotation
.end field

.field private g:Ljava/lang/String;

.field private h:Ljava/lang/String;

.field private i:Ljava/lang/String;

.field private j:I

.field private k:Z

.field private l:I

.field private m:Ljava/lang/String;

.field private n:I


# direct methods
.method public constructor <init>()V
    .locals 0

    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    return-void
.end method


# virtual methods
.method public a()Ljava/lang/String;
    .locals 1

    iget-object v0, p0, Lchat/ola/vn/entity/y;->a:Ljava/lang/String;

    return-object v0
.end method

.method public a(I)V
    .locals 0

    iput p1, p0, Lchat/ola/vn/entity/y;->j:I

    return-void
.end method

.method public a(Ljava/lang/String;)V
    .locals 0

    iput-object p1, p0, Lchat/ola/vn/entity/y;->a:Ljava/lang/String;

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

    iput-object p1, p0, Lchat/ola/vn/entity/y;->f:Ljava/util/List;

    return-void
.end method

.method public a(Z)V
    .locals 0

    iput-boolean p1, p0, Lchat/ola/vn/entity/y;->k:Z

    return-void
.end method

.method public b()Ljava/lang/String;
    .locals 1

    iget-object v0, p0, Lchat/ola/vn/entity/y;->b:Ljava/lang/String;

    return-object v0
.end method

.method public b(I)V
    .locals 0

    iput p1, p0, Lchat/ola/vn/entity/y;->l:I

    return-void
.end method

.method public b(Ljava/lang/String;)V
    .locals 0

    iput-object p1, p0, Lchat/ola/vn/entity/y;->b:Ljava/lang/String;

    return-void
.end method

.method public c()Ljava/lang/String;
    .locals 1

    iget-object v0, p0, Lchat/ola/vn/entity/y;->c:Ljava/lang/String;

    return-object v0
.end method

.method public c(I)V
    .locals 0

    iput p1, p0, Lchat/ola/vn/entity/y;->n:I

    return-void
.end method

.method public c(Ljava/lang/String;)V
    .locals 0

    iput-object p1, p0, Lchat/ola/vn/entity/y;->c:Ljava/lang/String;

    return-void
.end method

.method public d()Ljava/lang/String;
    .locals 1

    iget-object v0, p0, Lchat/ola/vn/entity/y;->d:Ljava/lang/String;

    return-object v0
.end method

.method public d(Ljava/lang/String;)V
    .locals 0

    iput-object p1, p0, Lchat/ola/vn/entity/y;->d:Ljava/lang/String;

    return-void
.end method

.method public e()Lchat/ola/vn/entity/OlaVenueEntity;
    .locals 2

    :try_start_0
    new-instance v0, Lchat/ola/vn/entity/OlaVenueEntity;

    invoke-direct {v0}, Lchat/ola/vn/entity/OlaVenueEntity;-><init>()V

    iget-object v1, p0, Lchat/ola/vn/entity/y;->d:Ljava/lang/String;

    invoke-virtual {v0, v1}, Lchat/ola/vn/entity/OlaVenueEntity;->d(Ljava/lang/String;)V

    iget-object v1, p0, Lchat/ola/vn/entity/y;->c:Ljava/lang/String;

    invoke-virtual {v0, v1}, Lchat/ola/vn/entity/OlaVenueEntity;->c(Ljava/lang/String;)V

    iget-object v1, p0, Lchat/ola/vn/entity/y;->g:Ljava/lang/String;

    invoke-virtual {v0, v1}, Lchat/ola/vn/entity/OlaVenueEntity;->h(Ljava/lang/String;)V

    iget-object v1, p0, Lchat/ola/vn/entity/y;->i:Ljava/lang/String;

    invoke-virtual {v0, v1}, Lchat/ola/vn/entity/OlaVenueEntity;->g(Ljava/lang/String;)V

    iget-object v1, p0, Lchat/ola/vn/entity/y;->h:Ljava/lang/String;

    invoke-virtual {v0, v1}, Lchat/ola/vn/entity/OlaVenueEntity;->f(Ljava/lang/String;)V

    iget-object v1, p0, Lchat/ola/vn/entity/y;->e:Ljava/lang/String;

    invoke-virtual {v0, v1}, Lchat/ola/vn/entity/OlaVenueEntity;->e(Ljava/lang/String;)V

    iget-object v1, p0, Lchat/ola/vn/entity/y;->b:Ljava/lang/String;

    invoke-virtual {v0, v1}, Lchat/ola/vn/entity/OlaVenueEntity;->b(Ljava/lang/String;)V

    iget v1, p0, Lchat/ola/vn/entity/y;->j:I

    invoke-virtual {v0, v1}, Lchat/ola/vn/entity/OlaVenueEntity;->a(I)V

    iget-object v1, p0, Lchat/ola/vn/entity/y;->a:Ljava/lang/String;

    invoke-virtual {v0, v1}, Lchat/ola/vn/entity/OlaVenueEntity;->a(Ljava/lang/String;)V
    :try_end_0
    .catch Ljava/lang/Throwable; {:try_start_0 .. :try_end_0} :catch_0

    return-object v0

    :catch_0
    move-exception v0

    invoke-virtual {v0}, Ljava/lang/Throwable;->printStackTrace()V

    const/4 v0, 0x0

    return-object v0
.end method

.method public e(Ljava/lang/String;)V
    .locals 0

    iput-object p1, p0, Lchat/ola/vn/entity/y;->h:Ljava/lang/String;

    return-void
.end method

.method public f()Ljava/lang/String;
    .locals 1

    iget-object v0, p0, Lchat/ola/vn/entity/y;->h:Ljava/lang/String;

    return-object v0
.end method

.method public f(Ljava/lang/String;)V
    .locals 0

    iput-object p1, p0, Lchat/ola/vn/entity/y;->i:Ljava/lang/String;

    return-void
.end method

.method public g()Ljava/lang/String;
    .locals 1

    iget-object v0, p0, Lchat/ola/vn/entity/y;->i:Ljava/lang/String;

    return-object v0
.end method

.method public g(Ljava/lang/String;)V
    .locals 0

    iput-object p1, p0, Lchat/ola/vn/entity/y;->e:Ljava/lang/String;

    return-void
.end method

.method public h()I
    .locals 1

    iget v0, p0, Lchat/ola/vn/entity/y;->j:I

    return v0
.end method

.method public h(Ljava/lang/String;)V
    .locals 0

    iput-object p1, p0, Lchat/ola/vn/entity/y;->m:Ljava/lang/String;

    return-void
.end method

.method public i()Ljava/lang/String;
    .locals 1

    iget-object v0, p0, Lchat/ola/vn/entity/y;->e:Ljava/lang/String;

    return-object v0
.end method

.method public i(Ljava/lang/String;)V
    .locals 0

    iput-object p1, p0, Lchat/ola/vn/entity/y;->g:Ljava/lang/String;

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

    iget-object v0, p0, Lchat/ola/vn/entity/y;->f:Ljava/util/List;

    return-object v0
.end method

.method public k()Ljava/lang/String;
    .locals 1

    iget-object v0, p0, Lchat/ola/vn/entity/y;->m:Ljava/lang/String;

    return-object v0
.end method

.method public l()Ljava/lang/String;
    .locals 1

    iget-object v0, p0, Lchat/ola/vn/entity/y;->g:Ljava/lang/String;

    return-object v0
.end method
