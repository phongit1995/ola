.class final Lchat/ola/vn/h/b$3;
.super Landroid/os/AsyncTask;


# annotations
.annotation system Ldalvik/annotation/EnclosingMethod;
    value = Lchat/ola/vn/h/b;->b(Ljava/lang/String;B)V
.end annotation

.annotation system Ldalvik/annotation/InnerClass;
    accessFlags = 0x8
    name = null
.end annotation

.annotation system Ldalvik/annotation/Signature;
    value = {
        "Landroid/os/AsyncTask<",
        "Ljava/lang/Void;",
        "Ljava/lang/Void;",
        "Ljava/lang/Void;",
        ">;"
    }
.end annotation


# instance fields
.field final synthetic a:Ljava/lang/String;

.field final synthetic b:B


# direct methods
.method constructor <init>(Ljava/lang/String;B)V
    .locals 0

    iput-object p1, p0, Lchat/ola/vn/h/b$3;->a:Ljava/lang/String;

    iput-byte p2, p0, Lchat/ola/vn/h/b$3;->b:B

    invoke-direct {p0}, Landroid/os/AsyncTask;-><init>()V

    return-void
.end method


# virtual methods
.method protected varargs a([Ljava/lang/Void;)Ljava/lang/Void;
    .locals 2

    iget-object p1, p0, Lchat/ola/vn/h/b$3;->a:Ljava/lang/String;

    iget-byte v0, p0, Lchat/ola/vn/h/b$3;->b:B

    invoke-static {v0}, Ljava/lang/String;->valueOf(I)Ljava/lang/String;

    move-result-object v0

    const/16 v1, 0x3f

    invoke-static {p1, v1, v0}, Lchat/ola/vn/h/b;->a(Ljava/lang/String;SLjava/lang/String;)V

    const/4 p1, 0x0

    return-object p1
.end method

.method protected synthetic doInBackground([Ljava/lang/Object;)Ljava/lang/Object;
    .locals 0

    check-cast p1, [Ljava/lang/Void;

    invoke-virtual {p0, p1}, Lchat/ola/vn/h/b$3;->a([Ljava/lang/Void;)Ljava/lang/Void;

    move-result-object p1

    return-object p1
.end method
