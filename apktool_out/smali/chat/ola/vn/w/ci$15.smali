.class Lchat/ola/vn/w/ci$15;
.super Ljava/lang/Object;

# interfaces
.implements Ljava/lang/Runnable;


# annotations
.annotation system Ldalvik/annotation/EnclosingMethod;
    value = Lchat/ola/vn/w/ci;->a(Ljava/lang/String;JLjava/lang/String;SSLjava/lang/String;Ljava/lang/String;BS)V
.end annotation

.annotation system Ldalvik/annotation/InnerClass;
    accessFlags = 0x0
    name = null
.end annotation


# instance fields
.field final synthetic a:Ljava/lang/String;

.field final synthetic b:J

.field final synthetic c:Ljava/lang/String;

.field final synthetic d:S

.field final synthetic e:S

.field final synthetic f:Ljava/lang/String;

.field final synthetic g:B

.field final synthetic h:Ljava/lang/String;

.field final synthetic i:S

.field final synthetic j:Lchat/ola/vn/w/ci;


# direct methods
.method constructor <init>(Lchat/ola/vn/w/ci;Ljava/lang/String;JLjava/lang/String;SSLjava/lang/String;BLjava/lang/String;S)V
    .locals 0

    iput-object p1, p0, Lchat/ola/vn/w/ci$15;->j:Lchat/ola/vn/w/ci;

    iput-object p2, p0, Lchat/ola/vn/w/ci$15;->a:Ljava/lang/String;

    iput-wide p3, p0, Lchat/ola/vn/w/ci$15;->b:J

    iput-object p5, p0, Lchat/ola/vn/w/ci$15;->c:Ljava/lang/String;

    iput-short p6, p0, Lchat/ola/vn/w/ci$15;->d:S

    iput-short p7, p0, Lchat/ola/vn/w/ci$15;->e:S

    iput-object p8, p0, Lchat/ola/vn/w/ci$15;->f:Ljava/lang/String;

    iput-byte p9, p0, Lchat/ola/vn/w/ci$15;->g:B

    iput-object p10, p0, Lchat/ola/vn/w/ci$15;->h:Ljava/lang/String;

    iput-short p11, p0, Lchat/ola/vn/w/ci$15;->i:S

    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    return-void
.end method


# virtual methods
.method public run()V
    .locals 3

    new-instance v0, Lchat/ola/vn/w/bk;

    const/16 v1, 0x6a

    invoke-direct {v0, v1}, Lchat/ola/vn/w/bk;-><init>(S)V

    iget-object v1, p0, Lchat/ola/vn/w/ci$15;->a:Ljava/lang/String;

    iput-object v1, v0, Lchat/ola/vn/w/bk;->m:Ljava/lang/String;

    iget-wide v1, p0, Lchat/ola/vn/w/ci$15;->b:J

    iput-wide v1, v0, Lchat/ola/vn/w/bk;->S:J

    iget-object v1, p0, Lchat/ola/vn/w/ci$15;->c:Ljava/lang/String;

    iput-object v1, v0, Lchat/ola/vn/w/bk;->s:Ljava/lang/String;

    iget-short v1, p0, Lchat/ola/vn/w/ci$15;->d:S

    iput-short v1, v0, Lchat/ola/vn/w/bk;->ak:S

    iget-short v1, p0, Lchat/ola/vn/w/ci$15;->e:S

    iput-short v1, v0, Lchat/ola/vn/w/bk;->ai:S

    iget-object v1, p0, Lchat/ola/vn/w/ci$15;->f:Ljava/lang/String;

    iput-object v1, v0, Lchat/ola/vn/w/bk;->c:Ljava/lang/String;

    iget-byte v1, p0, Lchat/ola/vn/w/ci$15;->g:B

    iput-byte v1, v0, Lchat/ola/vn/w/bk;->as:B

    iget-object v1, p0, Lchat/ola/vn/w/ci$15;->h:Ljava/lang/String;

    if-eqz v1, :cond_0

    new-instance v1, Ljava/lang/StringBuilder;

    invoke-direct {v1}, Ljava/lang/StringBuilder;-><init>()V

    const-string v2, "{\"checkInId\":\""

    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    iget-object v2, p0, Lchat/ola/vn/w/ci$15;->h:Ljava/lang/String;

    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    const-string v2, "\"}"

    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    invoke-virtual {v1}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v1

    iput-object v1, v0, Lchat/ola/vn/w/bk;->D:Ljava/lang/String;

    :cond_0
    iget-short v1, p0, Lchat/ola/vn/w/ci$15;->i:S

    iput-short v1, v0, Lchat/ola/vn/w/bk;->aj:S

    iget-object v1, p0, Lchat/ola/vn/w/ci$15;->j:Lchat/ola/vn/w/ci;

    invoke-static {v1, v0}, Lchat/ola/vn/w/ci;->a(Lchat/ola/vn/w/ci;Lchat/ola/vn/w/bk;)V

    return-void
.end method
