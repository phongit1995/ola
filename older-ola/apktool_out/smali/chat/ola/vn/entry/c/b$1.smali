.class Lchat/ola/vn/entry/c/b$1;
.super Ljava/lang/Object;

# interfaces
.implements Landroid/content/DialogInterface$OnClickListener;


# annotations
.annotation system Ldalvik/annotation/EnclosingMethod;
    value = Lchat/ola/vn/entry/c/b;->a([Ljava/lang/Object;)V
.end annotation

.annotation system Ldalvik/annotation/InnerClass;
    accessFlags = 0x0
    name = null
.end annotation


# instance fields
.field final synthetic a:Lchat/ola/vn/entry/c/b;


# direct methods
.method constructor <init>(Lchat/ola/vn/entry/c/b;)V
    .locals 0

    iput-object p1, p0, Lchat/ola/vn/entry/c/b$1;->a:Lchat/ola/vn/entry/c/b;

    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    return-void
.end method


# virtual methods
.method public onClick(Landroid/content/DialogInterface;I)V
    .locals 0

    if-nez p2, :cond_0

    const/16 p2, 0xb

    sput-short p2, Lchat/ola/vn/c/x;->j:S

    invoke-static {}, Lchat/ola/vn/c;->c()Lchat/ola/vn/c;

    move-result-object p2

    invoke-static {p2}, Lchat/ola/vn/me/OlaMeComposerActivity;->a(Landroid/content/Context;)V

    :cond_0
    invoke-interface {p1}, Landroid/content/DialogInterface;->dismiss()V

    return-void
.end method
