.class Lchat/ola/vn/me/OlaDiaryActivity$6;
.super Ljava/lang/Object;

# interfaces
.implements Landroid/content/DialogInterface$OnClickListener;


# annotations
.annotation system Ldalvik/annotation/EnclosingMethod;
    value = Lchat/ola/vn/me/OlaDiaryActivity;->a(Ljava/lang/String;Ljava/lang/String;[Lchat/ola/vn/entity/g;S)V
.end annotation

.annotation system Ldalvik/annotation/InnerClass;
    accessFlags = 0x0
    name = null
.end annotation


# instance fields
.field final synthetic a:Lchat/ola/vn/me/OlaDiaryActivity;


# direct methods
.method constructor <init>(Lchat/ola/vn/me/OlaDiaryActivity;)V
    .locals 0

    iput-object p1, p0, Lchat/ola/vn/me/OlaDiaryActivity$6;->a:Lchat/ola/vn/me/OlaDiaryActivity;

    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    return-void
.end method


# virtual methods
.method public onClick(Landroid/content/DialogInterface;I)V
    .locals 0

    if-nez p2, :cond_0

    iget-object p2, p0, Lchat/ola/vn/me/OlaDiaryActivity$6;->a:Lchat/ola/vn/me/OlaDiaryActivity;

    invoke-static {p2}, Lchat/ola/vn/me/OlaMeComposerActivity;->b(Landroid/content/Context;)V

    :cond_0
    invoke-interface {p1}, Landroid/content/DialogInterface;->dismiss()V

    return-void
.end method
