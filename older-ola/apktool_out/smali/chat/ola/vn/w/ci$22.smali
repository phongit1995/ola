.class Lchat/ola/vn/w/ci$22;
.super Ljava/lang/Object;

# interfaces
.implements Ljava/lang/Runnable;


# annotations
.annotation system Ldalvik/annotation/EnclosingMethod;
    value = Lchat/ola/vn/w/ci;->a(JLjava/lang/String;S)V
.end annotation

.annotation system Ldalvik/annotation/InnerClass;
    accessFlags = 0x0
    name = null
.end annotation


# instance fields
.field final synthetic a:S

.field final synthetic b:J

.field final synthetic c:Ljava/lang/String;

.field final synthetic d:Lchat/ola/vn/w/ci;


# direct methods
.method constructor <init>(Lchat/ola/vn/w/ci;SJLjava/lang/String;)V
    .locals 0

    iput-object p1, p0, Lchat/ola/vn/w/ci$22;->d:Lchat/ola/vn/w/ci;

    iput-short p2, p0, Lchat/ola/vn/w/ci$22;->a:S

    iput-wide p3, p0, Lchat/ola/vn/w/ci$22;->b:J

    iput-object p5, p0, Lchat/ola/vn/w/ci$22;->c:Ljava/lang/String;

    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    return-void
.end method


# virtual methods
.method public run()V
    .locals 3

    new-instance v0, Lchat/ola/vn/w/bk;

    const/16 v1, 0x57

    invoke-direct {v0, v1}, Lchat/ola/vn/w/bk;-><init>(S)V

    iget-short v1, p0, Lchat/ola/vn/w/ci$22;->a:S

    if-lez v1, :cond_0

    iget-short v1, p0, Lchat/ola/vn/w/ci$22;->a:S

    iput-short v1, v0, Lchat/ola/vn/w/bk;->ai:S

    :cond_0
    iget-wide v1, p0, Lchat/ola/vn/w/ci$22;->b:J

    iput-wide v1, v0, Lchat/ola/vn/w/bk;->R:J

    iget-object v1, p0, Lchat/ola/vn/w/ci$22;->c:Ljava/lang/String;

    iput-object v1, v0, Lchat/ola/vn/w/bk;->m:Ljava/lang/String;

    iget-object v1, p0, Lchat/ola/vn/w/ci$22;->d:Lchat/ola/vn/w/ci;

    invoke-static {v1, v0}, Lchat/ola/vn/w/ci;->a(Lchat/ola/vn/w/ci;Lchat/ola/vn/w/bk;)V

    return-void
.end method
