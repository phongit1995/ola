.class Lchat/ola/vn/w/ci$19;
.super Ljava/lang/Object;

# interfaces
.implements Ljava/lang/Runnable;


# annotations
.annotation system Ldalvik/annotation/EnclosingMethod;
    value = Lchat/ola/vn/w/ci;->a(JZLjava/lang/String;Ljava/lang/String;S)V
.end annotation

.annotation system Ldalvik/annotation/InnerClass;
    accessFlags = 0x0
    name = null
.end annotation


# instance fields
.field final synthetic a:S

.field final synthetic b:J

.field final synthetic c:Ljava/lang/String;

.field final synthetic d:Ljava/lang/String;

.field final synthetic e:Z

.field final synthetic f:Lchat/ola/vn/w/ci;


# direct methods
.method constructor <init>(Lchat/ola/vn/w/ci;SJLjava/lang/String;Ljava/lang/String;Z)V
    .locals 0

    iput-object p1, p0, Lchat/ola/vn/w/ci$19;->f:Lchat/ola/vn/w/ci;

    iput-short p2, p0, Lchat/ola/vn/w/ci$19;->a:S

    iput-wide p3, p0, Lchat/ola/vn/w/ci$19;->b:J

    iput-object p5, p0, Lchat/ola/vn/w/ci$19;->c:Ljava/lang/String;

    iput-object p6, p0, Lchat/ola/vn/w/ci$19;->d:Ljava/lang/String;

    iput-boolean p7, p0, Lchat/ola/vn/w/ci$19;->e:Z

    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    return-void
.end method


# virtual methods
.method public run()V
    .locals 3

    new-instance v0, Lchat/ola/vn/w/bk;

    const/16 v1, 0x55

    invoke-direct {v0, v1}, Lchat/ola/vn/w/bk;-><init>(S)V

    iget-short v1, p0, Lchat/ola/vn/w/ci$19;->a:S

    iput-short v1, v0, Lchat/ola/vn/w/bk;->aj:S

    iget-wide v1, p0, Lchat/ola/vn/w/ci$19;->b:J

    iput-wide v1, v0, Lchat/ola/vn/w/bk;->R:J

    iget-object v1, p0, Lchat/ola/vn/w/ci$19;->c:Ljava/lang/String;

    invoke-static {v1}, Lchat/ola/vn/util/m;->c(Ljava/lang/String;)Z

    move-result v1

    if-nez v1, :cond_0

    iget-object v1, p0, Lchat/ola/vn/w/ci$19;->d:Ljava/lang/String;

    invoke-static {v1}, Lchat/ola/vn/util/m;->c(Ljava/lang/String;)Z

    move-result v1

    if-nez v1, :cond_0

    new-instance v1, Ljava/lang/StringBuilder;

    invoke-direct {v1}, Ljava/lang/StringBuilder;-><init>()V

    iget-object v2, p0, Lchat/ola/vn/w/ci$19;->c:Ljava/lang/String;

    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    const-string v2, " "

    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    iget-object v2, p0, Lchat/ola/vn/w/ci$19;->d:Ljava/lang/String;

    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    invoke-virtual {v1}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v1

    iput-object v1, v0, Lchat/ola/vn/w/bk;->c:Ljava/lang/String;

    :cond_0
    iget-boolean v1, p0, Lchat/ola/vn/w/ci$19;->e:Z

    if-eqz v1, :cond_1

    const/4 v1, 0x1

    :goto_0
    iput-byte v1, v0, Lchat/ola/vn/w/bk;->as:B

    goto :goto_1

    :cond_1
    const/4 v1, 0x0

    goto :goto_0

    :goto_1
    iget-object v1, p0, Lchat/ola/vn/w/ci$19;->f:Lchat/ola/vn/w/ci;

    invoke-static {v1, v0}, Lchat/ola/vn/w/ci;->a(Lchat/ola/vn/w/ci;Lchat/ola/vn/w/bk;)V

    return-void
.end method
