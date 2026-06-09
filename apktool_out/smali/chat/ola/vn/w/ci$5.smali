.class Lchat/ola/vn/w/ci$5;
.super Ljava/lang/Object;

# interfaces
.implements Ljava/lang/Runnable;


# annotations
.annotation system Ldalvik/annotation/EnclosingMethod;
    value = Lchat/ola/vn/w/ci;->a(JS)V
.end annotation

.annotation system Ldalvik/annotation/InnerClass;
    accessFlags = 0x0
    name = null
.end annotation


# instance fields
.field final synthetic a:J

.field final synthetic b:S

.field final synthetic c:Lchat/ola/vn/w/ci;


# direct methods
.method constructor <init>(Lchat/ola/vn/w/ci;JS)V
    .locals 0

    iput-object p1, p0, Lchat/ola/vn/w/ci$5;->c:Lchat/ola/vn/w/ci;

    iput-wide p2, p0, Lchat/ola/vn/w/ci$5;->a:J

    iput-short p4, p0, Lchat/ola/vn/w/ci$5;->b:S

    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    return-void
.end method


# virtual methods
.method public run()V
    .locals 3

    new-instance v0, Lchat/ola/vn/w/bk;

    const/16 v1, 0x67

    invoke-direct {v0, v1}, Lchat/ola/vn/w/bk;-><init>(S)V

    iget-wide v1, p0, Lchat/ola/vn/w/ci$5;->a:J

    iput-wide v1, v0, Lchat/ola/vn/w/bk;->S:J

    const/4 v1, 0x1

    iput-byte v1, v0, Lchat/ola/vn/w/bk;->at:B

    iget-short v1, p0, Lchat/ola/vn/w/ci$5;->b:S

    iput-short v1, v0, Lchat/ola/vn/w/bk;->aj:S

    iget-object v1, p0, Lchat/ola/vn/w/ci$5;->c:Lchat/ola/vn/w/ci;

    invoke-static {v1, v0}, Lchat/ola/vn/w/ci;->a(Lchat/ola/vn/w/ci;Lchat/ola/vn/w/bk;)V

    return-void
.end method
