.class final Lchat/ola/vn/h/b$12;
.super Landroid/os/AsyncTask;


# annotations
.annotation system Ldalvik/annotation/EnclosingMethod;
    value = Lchat/ola/vn/h/b;->a(Ljava/lang/String;Lchat/ola/vn/me/a;)V
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
.field final synthetic a:Lchat/ola/vn/me/a;

.field final synthetic b:Ljava/lang/String;


# direct methods
.method constructor <init>(Lchat/ola/vn/me/a;Ljava/lang/String;)V
    .locals 0

    iput-object p1, p0, Lchat/ola/vn/h/b$12;->a:Lchat/ola/vn/me/a;

    iput-object p2, p0, Lchat/ola/vn/h/b$12;->b:Ljava/lang/String;

    invoke-direct {p0}, Landroid/os/AsyncTask;-><init>()V

    return-void
.end method


# virtual methods
.method protected varargs a([Ljava/lang/Void;)Ljava/lang/Void;
    .locals 2

    const-string p1, ""

    :try_start_0
    iget-object v0, p0, Lchat/ola/vn/h/b$12;->a:Lchat/ola/vn/me/a;

    invoke-virtual {v0}, Lchat/ola/vn/me/a;->toString()Ljava/lang/String;

    move-result-object v0
    :try_end_0
    .catch Ljava/lang/Throwable; {:try_start_0 .. :try_end_0} :catch_0

    move-object p1, v0

    :catch_0
    iget-object v0, p0, Lchat/ola/vn/h/b$12;->b:Ljava/lang/String;

    const/16 v1, 0x6f

    invoke-static {v0, v1, p1}, Lchat/ola/vn/h/b;->a(Ljava/lang/String;SLjava/lang/String;)V

    const/4 p1, 0x0

    return-object p1
.end method

.method protected synthetic doInBackground([Ljava/lang/Object;)Ljava/lang/Object;
    .locals 0

    check-cast p1, [Ljava/lang/Void;

    invoke-virtual {p0, p1}, Lchat/ola/vn/h/b$12;->a([Ljava/lang/Void;)Ljava/lang/Void;

    move-result-object p1

    return-object p1
.end method
