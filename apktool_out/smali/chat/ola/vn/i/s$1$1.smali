.class Lchat/ola/vn/i/s$1$1;
.super Ljava/lang/Object;

# interfaces
.implements Ljava/lang/Runnable;


# annotations
.annotation system Ldalvik/annotation/EnclosingMethod;
    value = Lchat/ola/vn/i/s$1;->a(II)V
.end annotation

.annotation system Ldalvik/annotation/InnerClass;
    accessFlags = 0x0
    name = null
.end annotation


# instance fields
.field final synthetic a:I

.field final synthetic b:I

.field final synthetic c:Lchat/ola/vn/i/s$1;


# direct methods
.method constructor <init>(Lchat/ola/vn/i/s$1;II)V
    .locals 0

    iput-object p1, p0, Lchat/ola/vn/i/s$1$1;->c:Lchat/ola/vn/i/s$1;

    iput p2, p0, Lchat/ola/vn/i/s$1$1;->a:I

    iput p3, p0, Lchat/ola/vn/i/s$1$1;->b:I

    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    return-void
.end method


# virtual methods
.method public run()V
    .locals 5

    iget-object v0, p0, Lchat/ola/vn/i/s$1$1;->c:Lchat/ola/vn/i/s$1;

    iget-object v0, v0, Lchat/ola/vn/i/s$1;->b:Lchat/ola/vn/i/s;

    iget v1, p0, Lchat/ola/vn/i/s$1$1;->a:I

    int-to-long v1, v1

    iget v3, p0, Lchat/ola/vn/i/s$1$1;->b:I

    int-to-long v3, v3

    invoke-static {v0, v1, v2, v3, v4}, Lchat/ola/vn/i/s;->a(Lchat/ola/vn/i/s;JJ)V

    return-void
.end method
