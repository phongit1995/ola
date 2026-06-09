.class public Lchat/ola/vn/message/j;
.super Lchat/ola/vn/message/d;


# instance fields
.field protected z:J


# direct methods
.method public constructor <init>(Lchat/ola/vn/message/d;B)V
    .locals 1

    const/16 v0, 0xf

    invoke-direct {p0, p1, p2, v0}, Lchat/ola/vn/message/d;-><init>(Lchat/ola/vn/message/d;BB)V

    const-wide/16 p1, 0x0

    iput-wide p1, p0, Lchat/ola/vn/message/j;->z:J

    return-void
.end method


# virtual methods
.method public a()J
    .locals 2

    iget-wide v0, p0, Lchat/ola/vn/message/j;->z:J

    return-wide v0
.end method

.method a(Lchat/ola/vn/message/d;)V
    .locals 5

    invoke-super {p0, p1}, Lchat/ola/vn/message/d;->a(Lchat/ola/vn/message/d;)V

    :try_start_0
    check-cast p1, Lchat/ola/vn/message/j;

    const-wide/16 v0, 0x0

    iget-wide v2, p1, Lchat/ola/vn/message/j;->z:J

    cmp-long v4, v0, v2

    if-eqz v4, :cond_0

    iget-wide v0, p1, Lchat/ola/vn/message/j;->z:J

    iput-wide v0, p0, Lchat/ola/vn/message/j;->z:J
    :try_end_0
    .catch Ljava/lang/Throwable; {:try_start_0 .. :try_end_0} :catch_0

    :catch_0
    :cond_0
    return-void
.end method

.method public b()Z
    .locals 1

    const/4 v0, 0x0

    return v0
.end method

.method public c(J)V
    .locals 0

    iput-wide p1, p0, Lchat/ola/vn/message/j;->z:J

    return-void
.end method
