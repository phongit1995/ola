.class Lchat/ola/vn/w/ax;
.super Ljava/lang/Object;

# interfaces
.implements Lchat/ola/vn/w/bb;


# direct methods
.method constructor <init>()V
    .locals 0

    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    return-void
.end method


# virtual methods
.method public a(Lchat/ola/vn/w/bk;Lchat/ola/vn/w/cg;Lchat/ola/vn/p/g;)V
    .locals 0

    return-void
.end method

.method public a(Lchat/ola/vn/w/s;Lchat/ola/vn/p/g;Lchat/ola/vn/w/ci;)V
    .locals 11

    const/4 v0, 0x0

    const/16 v1, 0x2d

    invoke-virtual {p1, v1, v0}, Lchat/ola/vn/w/s;->b(SI)I

    move-result v1

    const/4 v2, -0x1

    invoke-virtual {p1, v1, v2}, Lchat/ola/vn/w/s;->a(IS)B

    move-result v1

    int-to-short v1, v1

    const/16 v3, 0x9

    invoke-virtual {p1, v3, v0}, Lchat/ola/vn/w/s;->b(SI)I

    move-result v0

    const-wide/16 v3, 0x0

    invoke-virtual {p1, v0, v3, v4}, Lchat/ola/vn/w/s;->a(IJ)J

    move-result-wide v5

    cmp-long p1, v5, v3

    if-ltz p1, :cond_2

    const-wide/32 v7, 0x36ee80

    div-long v9, v5, v7

    long-to-int p1, v9

    rem-long/2addr v5, v7

    cmp-long v0, v5, v3

    if-eqz v0, :cond_0

    add-int/lit8 p1, p1, 0x1

    :cond_0
    div-int/lit8 v0, p1, 0x18

    rem-int/lit8 p1, p1, 0x18

    if-eqz p1, :cond_1

    add-int/lit8 v0, v0, 0x1

    :cond_1
    move v2, v0

    :cond_2
    const/4 p1, 0x0

    if-ltz v1, :cond_3

    invoke-static {v1}, Ljava/lang/Short;->valueOf(S)Ljava/lang/Short;

    move-result-object p1

    iput-short v1, p3, Lchat/ola/vn/w/ci;->o:S

    :cond_3
    iput v2, p3, Lchat/ola/vn/w/ci;->n:I

    invoke-interface {p2, p1, v2}, Lchat/ola/vn/p/g;->a(Ljava/lang/Short;I)V

    return-void
.end method
