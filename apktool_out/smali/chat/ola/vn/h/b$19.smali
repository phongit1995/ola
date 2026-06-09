.class final Lchat/ola/vn/h/b$19;
.super Landroid/os/AsyncTask;


# annotations
.annotation system Ldalvik/annotation/EnclosingMethod;
    value = Lchat/ola/vn/h/b;->a(Ljava/lang/String;Ljava/lang/Long;)V
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
.field final synthetic a:Ljava/lang/Long;

.field final synthetic b:Ljava/lang/String;


# direct methods
.method constructor <init>(Ljava/lang/Long;Ljava/lang/String;)V
    .locals 0

    iput-object p1, p0, Lchat/ola/vn/h/b$19;->a:Ljava/lang/Long;

    iput-object p2, p0, Lchat/ola/vn/h/b$19;->b:Ljava/lang/String;

    invoke-direct {p0}, Landroid/os/AsyncTask;-><init>()V

    return-void
.end method


# virtual methods
.method protected varargs a([Ljava/lang/Void;)Ljava/lang/Void;
    .locals 2

    iget-object p1, p0, Lchat/ola/vn/h/b$19;->a:Ljava/lang/Long;

    const/16 v0, 0x58

    if-eqz p1, :cond_0

    iget-object p1, p0, Lchat/ola/vn/h/b$19;->b:Ljava/lang/String;

    iget-object v1, p0, Lchat/ola/vn/h/b$19;->a:Ljava/lang/Long;

    invoke-static {v1}, Ljava/lang/String;->valueOf(Ljava/lang/Object;)Ljava/lang/String;

    move-result-object v1

    :goto_0
    invoke-static {p1, v0, v1}, Lchat/ola/vn/h/b;->a(Ljava/lang/String;SLjava/lang/String;)V

    goto :goto_1

    :cond_0
    iget-object p1, p0, Lchat/ola/vn/h/b$19;->b:Ljava/lang/String;

    const-string v1, ""

    goto :goto_0

    :goto_1
    const/4 p1, 0x0

    return-object p1
.end method

.method protected synthetic doInBackground([Ljava/lang/Object;)Ljava/lang/Object;
    .locals 0

    check-cast p1, [Ljava/lang/Void;

    invoke-virtual {p0, p1}, Lchat/ola/vn/h/b$19;->a([Ljava/lang/Void;)Ljava/lang/Void;

    move-result-object p1

    return-object p1
.end method
