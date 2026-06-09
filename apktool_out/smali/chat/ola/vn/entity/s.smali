.class public Lchat/ola/vn/entity/s;
.super Ljava/lang/Object;


# instance fields
.field public a:Lchat/ola/vn/entity/k;

.field public b:J

.field private c:B

.field private d:J

.field private e:Ljava/lang/String;

.field private f:Ljava/lang/String;

.field private g:Z

.field private h:Ljava/lang/String;

.field private i:J


# direct methods
.method public constructor <init>()V
    .locals 3

    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    const-wide/16 v0, 0x0

    iput-wide v0, p0, Lchat/ola/vn/entity/s;->b:J

    const/4 v2, 0x0

    iput-byte v2, p0, Lchat/ola/vn/entity/s;->c:B

    iput-wide v0, p0, Lchat/ola/vn/entity/s;->d:J

    const/4 v0, 0x0

    iput-object v0, p0, Lchat/ola/vn/entity/s;->e:Ljava/lang/String;

    return-void
.end method

.method public constructor <init>(B)V
    .locals 3

    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    const-wide/16 v0, 0x0

    iput-wide v0, p0, Lchat/ola/vn/entity/s;->b:J

    const/4 v2, 0x0

    iput-byte v2, p0, Lchat/ola/vn/entity/s;->c:B

    iput-wide v0, p0, Lchat/ola/vn/entity/s;->d:J

    const/4 v0, 0x0

    iput-object v0, p0, Lchat/ola/vn/entity/s;->e:Ljava/lang/String;

    iput-byte p1, p0, Lchat/ola/vn/entity/s;->c:B

    return-void
.end method

.method public constructor <init>(JLjava/lang/String;)V
    .locals 2

    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    const-wide/16 v0, 0x0

    iput-wide v0, p0, Lchat/ola/vn/entity/s;->b:J

    const/4 v0, 0x0

    iput-byte v0, p0, Lchat/ola/vn/entity/s;->c:B

    iput-wide p1, p0, Lchat/ola/vn/entity/s;->d:J

    iput-object p3, p0, Lchat/ola/vn/entity/s;->e:Ljava/lang/String;

    return-void
.end method


# virtual methods
.method public a()J
    .locals 2

    iget-wide v0, p0, Lchat/ola/vn/entity/s;->i:J

    return-wide v0
.end method

.method public a(B)V
    .locals 0

    iput-byte p1, p0, Lchat/ola/vn/entity/s;->c:B

    return-void
.end method

.method public a(J)V
    .locals 0

    iput-wide p1, p0, Lchat/ola/vn/entity/s;->i:J

    return-void
.end method

.method public a(Ljava/lang/String;)V
    .locals 0

    iput-object p1, p0, Lchat/ola/vn/entity/s;->e:Ljava/lang/String;

    return-void
.end method

.method public b(Ljava/lang/String;)V
    .locals 3

    invoke-static {p1}, Lchat/ola/vn/util/m;->c(Ljava/lang/String;)Z

    move-result v0

    if-eqz v0, :cond_0

    return-void

    :cond_0
    const-string v0, ";"

    invoke-static {p1, v0}, Lchat/ola/vn/util/m;->e(Ljava/lang/String;Ljava/lang/String;)[Ljava/lang/String;

    move-result-object p1

    if-eqz p1, :cond_2

    const/4 v0, 0x0

    :goto_0
    array-length v1, p1

    if-ge v0, v1, :cond_2

    aget-object v1, p1, v0

    const-string v2, "gps"

    invoke-static {v1, v2}, Lchat/ola/vn/util/m;->b(Ljava/lang/String;Ljava/lang/String;)Z

    move-result v1

    if-eqz v1, :cond_1

    const/4 p1, 0x1

    iput-boolean p1, p0, Lchat/ola/vn/entity/s;->g:Z

    return-void

    :cond_1
    add-int/lit8 v0, v0, 0x1

    goto :goto_0

    :cond_2
    return-void
.end method

.method public b()Z
    .locals 5

    iget-wide v0, p0, Lchat/ola/vn/entity/s;->d:J

    const-wide/16 v2, 0x0

    cmp-long v4, v0, v2

    if-lez v4, :cond_0

    const/4 v0, 0x1

    return v0

    :cond_0
    const/4 v0, 0x0

    return v0
.end method

.method public c()J
    .locals 2

    iget-wide v0, p0, Lchat/ola/vn/entity/s;->d:J

    return-wide v0
.end method

.method public c(Ljava/lang/String;)V
    .locals 0

    iput-object p1, p0, Lchat/ola/vn/entity/s;->f:Ljava/lang/String;

    return-void
.end method

.method public d()Ljava/lang/String;
    .locals 1

    iget-object v0, p0, Lchat/ola/vn/entity/s;->e:Ljava/lang/String;

    return-object v0
.end method

.method public d(Ljava/lang/String;)V
    .locals 0

    iput-object p1, p0, Lchat/ola/vn/entity/s;->h:Ljava/lang/String;

    return-void
.end method

.method public e()Z
    .locals 1

    iget-boolean v0, p0, Lchat/ola/vn/entity/s;->g:Z

    return v0
.end method

.method public f()Ljava/lang/String;
    .locals 1

    iget-object v0, p0, Lchat/ola/vn/entity/s;->f:Ljava/lang/String;

    return-object v0
.end method

.method public g()Ljava/lang/String;
    .locals 1

    iget-object v0, p0, Lchat/ola/vn/entity/s;->h:Ljava/lang/String;

    return-object v0
.end method

.method public h()B
    .locals 1

    iget-byte v0, p0, Lchat/ola/vn/entity/s;->c:B

    return v0
.end method

.method public toString()Ljava/lang/String;
    .locals 3

    new-instance v0, Ljava/lang/StringBuilder;

    invoke-direct {v0}, Ljava/lang/StringBuilder;-><init>()V

    const-string v1, "[Room Id: ]"

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    iget-wide v1, p0, Lchat/ola/vn/entity/s;->d:J

    invoke-virtual {v0, v1, v2}, Ljava/lang/StringBuilder;->append(J)Ljava/lang/StringBuilder;

    const-string v1, " [Room Name: ]"

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    iget-object v1, p0, Lchat/ola/vn/entity/s;->e:Ljava/lang/String;

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    invoke-virtual {v0}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v0

    return-object v0
.end method
