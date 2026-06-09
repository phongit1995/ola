.class public Lchat/ola/vn/pickercontacts/f;
.super Ljava/lang/Object;


# instance fields
.field private a:Ljava/lang/String;

.field private b:Ljava/lang/ref/WeakReference;
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "Ljava/lang/ref/WeakReference<",
            "Lchat/ola/vn/view/OlaCachedImageView;",
            ">;"
        }
    .end annotation
.end field


# direct methods
.method public constructor <init>(Lchat/ola/vn/view/OlaCachedImageView;Ljava/lang/String;)V
    .locals 0

    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    iput-object p2, p0, Lchat/ola/vn/pickercontacts/f;->a:Ljava/lang/String;

    new-instance p2, Ljava/lang/ref/WeakReference;

    invoke-direct {p2, p1}, Ljava/lang/ref/WeakReference;-><init>(Ljava/lang/Object;)V

    iput-object p2, p0, Lchat/ola/vn/pickercontacts/f;->b:Ljava/lang/ref/WeakReference;

    return-void
.end method


# virtual methods
.method public a()Ljava/lang/ref/WeakReference;
    .locals 1
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "()",
            "Ljava/lang/ref/WeakReference<",
            "Lchat/ola/vn/view/OlaCachedImageView;",
            ">;"
        }
    .end annotation

    iget-object v0, p0, Lchat/ola/vn/pickercontacts/f;->b:Ljava/lang/ref/WeakReference;

    return-object v0
.end method

.method public b()Ljava/lang/String;
    .locals 1

    iget-object v0, p0, Lchat/ola/vn/pickercontacts/f;->a:Ljava/lang/String;

    return-object v0
.end method
