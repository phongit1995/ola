.class public Lchat/ola/vn/entity/o;
.super Ljava/lang/Object;


# instance fields
.field private a:Ljava/lang/String;

.field private b:Ljava/lang/String;

.field private c:Lchat/ola/vn/entity/OlaCheckInActionEntity;

.field private d:Ljava/util/List;
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "Ljava/util/List<",
            "Lchat/ola/vn/entity/OlaCheckInItemEntity;",
            ">;"
        }
    .end annotation
.end field

.field private e:Lchat/ola/vn/entity/OlaVenueEntity;

.field private f:J

.field private g:Ljava/lang/CharSequence;


# direct methods
.method public constructor <init>()V
    .locals 0

    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    return-void
.end method


# virtual methods
.method public a()Ljava/lang/String;
    .locals 1

    iget-object v0, p0, Lchat/ola/vn/entity/o;->a:Ljava/lang/String;

    return-object v0
.end method

.method public a(J)V
    .locals 0

    iput-wide p1, p0, Lchat/ola/vn/entity/o;->f:J

    return-void
.end method

.method public a(Lchat/ola/vn/entity/OlaCheckInActionEntity;)V
    .locals 0

    iput-object p1, p0, Lchat/ola/vn/entity/o;->c:Lchat/ola/vn/entity/OlaCheckInActionEntity;

    return-void
.end method

.method public a(Lchat/ola/vn/entity/OlaVenueEntity;)V
    .locals 0

    iput-object p1, p0, Lchat/ola/vn/entity/o;->e:Lchat/ola/vn/entity/OlaVenueEntity;

    return-void
.end method

.method public a(Ljava/lang/CharSequence;)V
    .locals 0

    iput-object p1, p0, Lchat/ola/vn/entity/o;->g:Ljava/lang/CharSequence;

    return-void
.end method

.method public a(Ljava/lang/String;)V
    .locals 0

    iput-object p1, p0, Lchat/ola/vn/entity/o;->a:Ljava/lang/String;

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

    iput-object p1, p0, Lchat/ola/vn/entity/o;->d:Ljava/util/List;

    return-void
.end method

.method public b()Lchat/ola/vn/entity/OlaCheckInActionEntity;
    .locals 1

    iget-object v0, p0, Lchat/ola/vn/entity/o;->c:Lchat/ola/vn/entity/OlaCheckInActionEntity;

    return-object v0
.end method

.method public b(Ljava/lang/String;)V
    .locals 0

    iput-object p1, p0, Lchat/ola/vn/entity/o;->b:Ljava/lang/String;

    return-void
.end method

.method public c()Ljava/util/List;
    .locals 1
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "()",
            "Ljava/util/List<",
            "Lchat/ola/vn/entity/OlaCheckInItemEntity;",
            ">;"
        }
    .end annotation

    iget-object v0, p0, Lchat/ola/vn/entity/o;->d:Ljava/util/List;

    return-object v0
.end method

.method public d()Lchat/ola/vn/entity/OlaVenueEntity;
    .locals 1

    iget-object v0, p0, Lchat/ola/vn/entity/o;->e:Lchat/ola/vn/entity/OlaVenueEntity;

    return-object v0
.end method

.method public e()Ljava/lang/CharSequence;
    .locals 1

    iget-object v0, p0, Lchat/ola/vn/entity/o;->g:Ljava/lang/CharSequence;

    return-object v0
.end method
