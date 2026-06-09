.class public Lchat/ola/vn/entity/OlaCheckInActionEntity;
.super Ljava/lang/Object;

# interfaces
.implements Ljava/io/Serializable;


# instance fields
.field private a:Ljava/lang/String;

.field private b:Ljava/lang/String;

.field private c:Ljava/lang/String;

.field private d:Ljava/lang/String;

.field private e:Z

.field private f:Ljava/util/List;
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "Ljava/util/List<",
            "Lchat/ola/vn/entity/OlaCheckInItemEntity;",
            ">;"
        }
    .end annotation
.end field

.field private g:Ljava/util/List;
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
    .locals 1

    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    const/4 v0, 0x1

    iput-boolean v0, p0, Lchat/ola/vn/entity/OlaCheckInActionEntity;->e:Z

    return-void
.end method


# virtual methods
.method public a()Ljava/lang/String;
    .locals 1

    iget-object v0, p0, Lchat/ola/vn/entity/OlaCheckInActionEntity;->a:Ljava/lang/String;

    return-object v0
.end method

.method public a(Lchat/ola/vn/entity/OlaCheckInActionEntity;)V
    .locals 2

    if-eqz p1, :cond_1

    iget-object v0, p1, Lchat/ola/vn/entity/OlaCheckInActionEntity;->a:Ljava/lang/String;

    iput-object v0, p0, Lchat/ola/vn/entity/OlaCheckInActionEntity;->a:Ljava/lang/String;

    iget-object v0, p1, Lchat/ola/vn/entity/OlaCheckInActionEntity;->b:Ljava/lang/String;

    iput-object v0, p0, Lchat/ola/vn/entity/OlaCheckInActionEntity;->b:Ljava/lang/String;

    iget-object v0, p1, Lchat/ola/vn/entity/OlaCheckInActionEntity;->c:Ljava/lang/String;

    iput-object v0, p0, Lchat/ola/vn/entity/OlaCheckInActionEntity;->c:Ljava/lang/String;

    iget-object v0, p1, Lchat/ola/vn/entity/OlaCheckInActionEntity;->d:Ljava/lang/String;

    iput-object v0, p0, Lchat/ola/vn/entity/OlaCheckInActionEntity;->d:Ljava/lang/String;

    iget-boolean v0, p1, Lchat/ola/vn/entity/OlaCheckInActionEntity;->e:Z

    iput-boolean v0, p0, Lchat/ola/vn/entity/OlaCheckInActionEntity;->e:Z

    iget-object v0, p1, Lchat/ola/vn/entity/OlaCheckInActionEntity;->f:Ljava/util/List;

    if-eqz v0, :cond_0

    new-instance v0, Ljava/util/ArrayList;

    iget-object v1, p1, Lchat/ola/vn/entity/OlaCheckInActionEntity;->f:Ljava/util/List;

    invoke-direct {v0, v1}, Ljava/util/ArrayList;-><init>(Ljava/util/Collection;)V

    iput-object v0, p0, Lchat/ola/vn/entity/OlaCheckInActionEntity;->f:Ljava/util/List;

    :cond_0
    iget-object v0, p1, Lchat/ola/vn/entity/OlaCheckInActionEntity;->g:Ljava/util/List;

    if-eqz v0, :cond_1

    new-instance v0, Ljava/util/ArrayList;

    iget-object p1, p1, Lchat/ola/vn/entity/OlaCheckInActionEntity;->g:Ljava/util/List;

    invoke-direct {v0, p1}, Ljava/util/ArrayList;-><init>(Ljava/util/Collection;)V

    iput-object v0, p0, Lchat/ola/vn/entity/OlaCheckInActionEntity;->g:Ljava/util/List;

    :cond_1
    return-void
.end method

.method public a(Ljava/lang/String;)V
    .locals 0

    iput-object p1, p0, Lchat/ola/vn/entity/OlaCheckInActionEntity;->a:Ljava/lang/String;

    return-void
.end method

.method public a(Ljava/util/List;)V
    .locals 0
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "(",
            "Ljava/util/List<",
            "Lchat/ola/vn/entity/OlaCheckInItemEntity;",
            ">;)V"
        }
    .end annotation

    iput-object p1, p0, Lchat/ola/vn/entity/OlaCheckInActionEntity;->f:Ljava/util/List;

    return-void
.end method

.method public a(Z)V
    .locals 0

    iput-boolean p1, p0, Lchat/ola/vn/entity/OlaCheckInActionEntity;->e:Z

    return-void
.end method

.method public b()Ljava/lang/String;
    .locals 1

    iget-object v0, p0, Lchat/ola/vn/entity/OlaCheckInActionEntity;->b:Ljava/lang/String;

    return-object v0
.end method

.method public b(Ljava/lang/String;)V
    .locals 0

    iput-object p1, p0, Lchat/ola/vn/entity/OlaCheckInActionEntity;->b:Ljava/lang/String;

    return-void
.end method

.method public b(Ljava/util/List;)V
    .locals 0
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "(",
            "Ljava/util/List<",
            "Ljava/lang/String;",
            ">;)V"
        }
    .end annotation

    iput-object p1, p0, Lchat/ola/vn/entity/OlaCheckInActionEntity;->g:Ljava/util/List;

    return-void
.end method

.method public c()Ljava/lang/String;
    .locals 1

    iget-object v0, p0, Lchat/ola/vn/entity/OlaCheckInActionEntity;->c:Ljava/lang/String;

    return-object v0
.end method

.method public c(Ljava/lang/String;)V
    .locals 0

    iput-object p1, p0, Lchat/ola/vn/entity/OlaCheckInActionEntity;->c:Ljava/lang/String;

    return-void
.end method

.method public d()Ljava/lang/String;
    .locals 1

    iget-object v0, p0, Lchat/ola/vn/entity/OlaCheckInActionEntity;->d:Ljava/lang/String;

    return-object v0
.end method

.method public d(Ljava/lang/String;)V
    .locals 0

    iput-object p1, p0, Lchat/ola/vn/entity/OlaCheckInActionEntity;->d:Ljava/lang/String;

    return-void
.end method

.method public e()Z
    .locals 1

    iget-boolean v0, p0, Lchat/ola/vn/entity/OlaCheckInActionEntity;->e:Z

    return v0
.end method

.method public f()Ljava/util/List;
    .locals 1
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "()",
            "Ljava/util/List<",
            "Lchat/ola/vn/entity/OlaCheckInItemEntity;",
            ">;"
        }
    .end annotation

    iget-object v0, p0, Lchat/ola/vn/entity/OlaCheckInActionEntity;->f:Ljava/util/List;

    return-object v0
.end method
