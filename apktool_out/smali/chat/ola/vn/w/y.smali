.class Lchat/ola/vn/w/y;
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
    .locals 3

    iget-object p3, p1, Lchat/ola/vn/w/bk;->i:Ljava/lang/String;

    invoke-static {p3}, Lchat/ola/vn/util/m;->a(Ljava/lang/String;)Z

    move-result p3

    if-nez p3, :cond_0

    const/16 p3, 0x16

    iget-object v0, p1, Lchat/ola/vn/w/bk;->i:Ljava/lang/String;

    invoke-virtual {p2, p3, v0}, Lchat/ola/vn/w/cg;->a(SLjava/lang/String;)V

    :cond_0
    iget-object p3, p1, Lchat/ola/vn/w/bk;->j:Ljava/lang/String;

    invoke-static {p3}, Lchat/ola/vn/util/m;->a(Ljava/lang/String;)Z

    move-result p3

    if-nez p3, :cond_1

    const/4 p3, 0x4

    iget-object v0, p1, Lchat/ola/vn/w/bk;->j:Ljava/lang/String;

    invoke-virtual {p2, p3, v0}, Lchat/ola/vn/w/cg;->a(SLjava/lang/String;)V

    :cond_1
    iget-object p3, p1, Lchat/ola/vn/w/bk;->O:Ljava/lang/Long;

    if-eqz p3, :cond_2

    invoke-static {}, Ljava/util/Calendar;->getInstance()Ljava/util/Calendar;

    move-result-object p3

    invoke-virtual {p3}, Ljava/util/Calendar;->getTimeZone()Ljava/util/TimeZone;

    move-result-object p3

    invoke-virtual {p3}, Ljava/util/TimeZone;->getID()Ljava/lang/String;

    move-result-object p3

    const/16 v0, 0x3a

    iget-object v1, p1, Lchat/ola/vn/w/bk;->O:Ljava/lang/Long;

    invoke-virtual {v1}, Ljava/lang/Long;->longValue()J

    move-result-wide v1

    invoke-virtual {p2, v0, v1, v2}, Lchat/ola/vn/w/cg;->a(SJ)V

    invoke-static {p3}, Lchat/ola/vn/util/m;->a(Ljava/lang/String;)Z

    move-result v0

    if-nez v0, :cond_2

    const/16 v0, 0x6d

    invoke-virtual {p2, v0, p3}, Lchat/ola/vn/w/cg;->a(SLjava/lang/String;)V

    :cond_2
    iget-object p3, p1, Lchat/ola/vn/w/bk;->ao:[B

    if-eqz p3, :cond_3

    const/16 p3, 0x17

    iget-object v0, p1, Lchat/ola/vn/w/bk;->ao:[B

    invoke-virtual {p2, p3, v0}, Lchat/ola/vn/w/cg;->a(S[B)V

    :cond_3
    iget-object p3, p1, Lchat/ola/vn/w/bk;->P:Ljava/lang/Byte;

    if-eqz p3, :cond_4

    const/16 p3, 0x58

    iget-object p1, p1, Lchat/ola/vn/w/bk;->P:Ljava/lang/Byte;

    invoke-virtual {p1}, Ljava/lang/Byte;->byteValue()B

    move-result p1

    invoke-virtual {p2, p3, p1}, Lchat/ola/vn/w/cg;->a(SB)V

    :cond_4
    return-void
.end method

.method public a(Lchat/ola/vn/w/s;Lchat/ola/vn/p/g;Lchat/ola/vn/w/ci;)V
    .locals 0

    invoke-interface {p2}, Lchat/ola/vn/p/g;->c()V

    return-void
.end method
