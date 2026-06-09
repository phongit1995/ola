.class Lchat/ola/vn/me/OlaMeComposerActivity$9;
.super Ljava/lang/Object;

# interfaces
.implements Ljava/lang/Runnable;


# annotations
.annotation system Ldalvik/annotation/EnclosingMethod;
    value = Lchat/ola/vn/me/OlaMeComposerActivity;->k(Ljava/lang/String;)V
.end annotation

.annotation system Ldalvik/annotation/InnerClass;
    accessFlags = 0x0
    name = null
.end annotation


# instance fields
.field final synthetic a:Lchat/ola/vn/me/OlaMeComposerActivity;


# direct methods
.method constructor <init>(Lchat/ola/vn/me/OlaMeComposerActivity;)V
    .locals 0

    iput-object p1, p0, Lchat/ola/vn/me/OlaMeComposerActivity$9;->a:Lchat/ola/vn/me/OlaMeComposerActivity;

    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    return-void
.end method


# virtual methods
.method public run()V
    .locals 2

    iget-object v0, p0, Lchat/ola/vn/me/OlaMeComposerActivity$9;->a:Lchat/ola/vn/me/OlaMeComposerActivity;

    invoke-static {v0}, Lchat/ola/vn/me/OlaMeComposerActivity;->b(Lchat/ola/vn/me/OlaMeComposerActivity;)Lit/sephiroth/android/library/widget/HListView;

    move-result-object v0

    iget-object v1, p0, Lchat/ola/vn/me/OlaMeComposerActivity$9;->a:Lchat/ola/vn/me/OlaMeComposerActivity;

    invoke-static {v1}, Lchat/ola/vn/me/OlaMeComposerActivity;->a(Lchat/ola/vn/me/OlaMeComposerActivity;)Lchat/ola/vn/b/s;

    move-result-object v1

    invoke-virtual {v1}, Lchat/ola/vn/b/s;->getCount()I

    move-result v1

    add-int/lit8 v1, v1, -0x1

    invoke-virtual {v0, v1}, Lit/sephiroth/android/library/widget/HListView;->c(I)V

    return-void
.end method
